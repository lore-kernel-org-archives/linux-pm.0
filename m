From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 5/5] powernv:cpufreq: Implement the driver->get()
 method
Date: Fri, 21 Mar 2014 19:55:55 +0530
Message-ID: <20140321142555.GF2493@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x==9JT-q2w95Ub_Ck_UMPcWY_4vo_Y44-i=DPjtu0jxwZg@mail.gmail.com>
 <20140321110445.GB2493@in.ibm.com>
 <CAKohpo=k-e1GLiLRNtJ3Xi3+NUWW1+gvtCNr_4Ag60j49dZvdQ@mail.gmail.com>
 <20140321130450.GD2493@in.ibm.com>
 <CAKohpomHHToqOND=ZtMeqBd11X3VA=PeZ2K6Tyj31y2V4G9-uA@mail.gmail.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:57769 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948AbaCUO0E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 21 Mar 2014 10:26:04 -0400
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Fri, 21 Mar 2014 10:26:03 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id CB623C90042
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 10:25:58 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s2LEQ2kt15990900
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 14:26:02 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s2LEQ1dl010349
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 10:26:02 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpomHHToqOND=ZtMeqBd11X3VA=PeZ2K6Tyj31y2V4G9-uA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Linux PM list <linux-pm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

On Fri, Mar 21, 2014 at 06:42:50PM +0530, Viresh Kumar wrote:
> On 21 March 2014 18:34, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> > Consider the case when pmspr = 0x00feffffffffffff;
> >
> > We are interested in extracting the value 'fe'. And ensure that when
> > we store this value into an int, we get the sign extension right.
> >
> > So the following doesn't work:
> >
> >    pstate_id = (pmspr_val >> 48) & 0xFFFFFFFF;
> 
> What about pstate_id = (pmspr_val >> 48) & 0xFF; ??

Nope. 

Suppose the pmspr_val is contained in the register 
%rax, and pstate_id corresponds to the address -20(%rbp) then:

	pstate_id = (pmspr_val >> 48) & 0xFF;

would corrspond to 

        shrq    $48, %rax        // Left shift by 48 bits
        andl    $255, %eax       // Mask the lower 32 bits of %rax with 0x000000FF
        movl    %eax, -20(%rbp)  // Store the lower 32 bits of %rax
                                    into pstate_id


On the other hand, 

   pstate_id = (int)((s8)((pmspr_val >> 48) & 0xFF));

would correspond to:

        shrq    $48, %rax  // Left shift by 48 bits.
        movsbl  %al, %eax  // Move the lower 8 bits of %rax to %eax
                              with sign-extension. 
        movl    %eax, -20(%rbp) // store the result in pstate_id;

So with this, we are getting the sign extension due to the use of movsbl.

And if local_pstate_id corresponds to the address -1(%rbp) then:

       local_pstate_id = (pmspr_val >> 48) & 0xFF;
       pstate_id = local_pstate_id;

would correspond to:

        shrq    $48, %rax        // Left shift by 48 bits
        movb    %al, -1(%rbp)    //copy the lower 8 bits to local_pstate_id
        movsbl  -1(%rbp), %eax   //move the contents of
                                   local_pstate_id to %eax with sign extension.
        movl    %eax, -20(%rbp)  // Store the result in pstate_id


Hope this helps :-)

--
Thanks and Regards
gautham.

