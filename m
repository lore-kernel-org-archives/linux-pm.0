From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v3 5/5] powernv:cpufreq: Implement the driver->get()
 method
Date: Fri, 21 Mar 2014 15:01:09 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6E5677@AcuExch.aculab.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
	<1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
	<CAOh2x==9JT-q2w95Ub_Ck_UMPcWY_4vo_Y44-i=DPjtu0jxwZg@mail.gmail.com>
	<20140321110445.GB2493@in.ibm.com>
	<CAKohpo=k-e1GLiLRNtJ3Xi3+NUWW1+gvtCNr_4Ag60j49dZvdQ@mail.gmail.com>
	<063D6719AE5E284EB5DD2968C1650D6D0F6E5386@AcuExch.aculab.com>
 <CAKohpo=E1UEcLhbZHtmBJcD3S3trm8ypT7++quF_t6XHDXAvHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0.aculab.com ([213.249.233.131]:32825 "HELO mx0.aculab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752673AbaCUPCg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 11:02:36 -0400
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 28225-04 for <linux-pm@vger.kernel.org>;
 Fri, 21 Mar 2014 15:02:35 +0000 (GMT)
In-Reply-To: <CAKohpo=E1UEcLhbZHtmBJcD3S3trm8ypT7++quF_t6XHDXAvHA@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Viresh Kumar' <viresh.kumar@linaro.org>
Cc: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Linux PM list <linux-pm@vger.kernel.org>

From: Viresh Kumar [mailto:viresh.kumar@linaro.org]
> On 21 March 2014 17:31, David Laight <David.Laight@aculab.com> wrote:
> >> *(int *)ret_freq = freq;
> >
> > Because it is very likely to be wrong.
> > In general casts of pointers to integer types are dangerous.
> 
> Where are we converting pointers to integers? We are doing a
> cast from 'void * ' to 'int *' and then using indirection operator
> to set its value.

You mis-parsed what I wrote, try:
In general casts of 'pointer to integer' types are dangerous.

Somewhere, much higher up the call stack, the address of an integer
variable is being taken and then passed as the 'void *' parameter.

The 'problem' is that it is quite easily to pass the address of
a 'long' instead. On 32bit and LE systems this won't always
be a problem. On 64bit BE it all goes wrong.

	David



