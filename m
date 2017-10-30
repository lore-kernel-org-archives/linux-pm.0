From: Brian Norris <briannorris@chromium.org>
Subject: Re: [RFC PATCH v8 4/7] of/irq: Adjust of pci irq parsing for
 multiple interrupts
Date: Mon, 30 Oct 2017 11:46:51 -0700
Message-ID: <20171030184649.GA99279@google.com>
References: <20171026132840.20946-1-jeffy.chen@rock-chips.com>
 <20171026132840.20946-5-jeffy.chen@rock-chips.com>
 <20171027143812.5i4vathfjpgld7wk@rob-hp-laptop>
 <59F688FF.9020806@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:55911 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752955AbdJ3Sqz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Oct 2017 14:46:55 -0400
Received: by mail-io0-f169.google.com with SMTP id p186so29442365ioe.12
        for <linux-pm@vger.kernel.org>; Mon, 30 Oct 2017 11:46:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <59F688FF.9020806@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jeffy <jeffy.chen@rock-chips.com>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, bhelgaas@google.com, linux-pm@vger.kernel.org, tony@atomide.com, shawn.lin@rock-chips.com, rjw@rjwysocki.net, dianders@chromium.org, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org

On Mon, Oct 30, 2017 at 10:05:51AM +0800, Jeffy Chen wrote:
> On 10/27/2017 10:38 PM, Rob Herring wrote:
> >>+		prop = of_find_property(dn, "interrupt-names", NULL);
> >>>+		for (name = of_prop_next_string(prop, NULL); name;
> >>>+		     name = of_prop_next_string(prop, name), index++) {
> >>>+			if (!strcmp(name, "pci"))
> >>>+				break;
> >Use of_property_match_string
> >
> i'm trying to find the first unnamed or "pci" named irq in the
> string array, so cannot use that API:)

Actually, why can't you? It does exactly what your loop does right now.
You'd just need to handle the -ENODATA case better. e.g., check if we
have an interrupt-names property -- if not, just take index 0; if so,
then use of_property_match_string().

Brian

> but will change to of_property_for_each_string as Brian suggested.
> 
