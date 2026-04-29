Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A5732ED3A
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472485; cv=none; b=SdbiMxmA7z49zB2VSUe3f7EYtzbxKm54hF8AjcU+L8cjWa5+1p1cQEdjYN4yguwa6EvsBdqN1Xml2ZSEvixKdIdjBSqqcI2vur0gkAHVnKvsdqn6NDrrbuNHtNoIE70N6CkWl07JPe7WGEil2lfTo9hj2EoeY2AdLKU5nkRZp68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472485; c=relaxed/simple;
	bh=kbxhMNJkZZbu7nKlsOnBfvstA5xuGbuqHRD/L7OXM7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrmeQMiBAOarnQED7Qr3OZ+n5lSGoUCbt6y0+R8Dhib61SMnAJliRREF/17EWwjj2mKJhdj8wg8+UV59EofULA3trtjMcmhD7UCxUSAxyc081ZiLTHc27NGUe+satovGJHLjvfI6kjkDY8gpLmy71JAlLffPAirj+vY8DZCpObU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=AMLKS52z; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="AMLKS52z"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8a3342d301aso121149116d6.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 07:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1777472482; x=1778077282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XiEzXlfXmI/3llZ2UFTHL2tqoNvlwiBItsKsnE3usGs=;
        b=AMLKS52z0zT8Z1Sb8ZsaffrmG7QXGVOKkH4iY40UlxemSku0Irp1I8mfw+aUm+d1up
         ZGHtN3Iayl48drccemcRFgEmQJGU/74OGqR5be6ARKqq98cxT0qerQ2qm+tC0Ay+TQli
         mOgI+MC4mZyUCA+4u0hyK+SfEBY+ogsDQH3ffPQyKT+21gIdoKjh0umibJLHwFiqwfnT
         je4V7+K+Xzm1AIwOCwLxs2aEC5KOc2YXVNGCVEDzOxBJKKW+SKyajlUEYeUliwhqszMq
         3F/u0NX07NDNLQd5CLzkkGHTKCvPs6Fb4p0okXvVvv7TDxTmbaOnOwP1TtzCe1sPERNA
         aX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777472482; x=1778077282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiEzXlfXmI/3llZ2UFTHL2tqoNvlwiBItsKsnE3usGs=;
        b=Hw16uwyQcGCZAYcmWG4PqsiFFws1IwkgojUHi64CPd0N80/c2/ezMlMBBw9QwJwCoS
         UPEkR4guiRqhlOtSYmmZaSsCWgJtNgsMVaDC59pn2YYWQNiL9b/EgQwahWTuIbWuh60n
         yo3wieew8XNQkzqj6MnIL8XgUTmIZ/QTA46PfvKNsjGViaTlc7eSLGn3f1EpP+hE9OFw
         WA5RLPuAe2r4poF6+rPkcoe4QVLMTV76SHauCNOR0pFMmxVGE/GE5b8sIkmxrEqqpied
         0n/L3bJmQPq/n+05BdYFP3O3ePB7cxikBkAgYiPRFoQSk/E0eRgtkcHnFaKUzMCrM0Sk
         YcbA==
X-Forwarded-Encrypted: i=1; AFNElJ8v9jPVUchHdQr9JFnExLOwZlkQvuhByKhoqjDmzXhGUOSlc31NCxAsgnFMvXBaJ9oVSZRAYASEsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ZV3OaoO4C2Gx+m/1gL9qtVcj6XnrJdpvyty/BY/460Itwsh4
	xsPSbmCLT9km1JSg9hLf+p6I4NENAqg/8SgLLpXhlHZIE7scsUM2JpXRqojuhk0zrw==
X-Gm-Gg: AeBDiesjrM5Oz3SZmlxeYgYMOxnyTzFEhHScuzdLpfFoYCQNWCdX+IkxeSprLfJmWjw
	qrKmlUmskvavSgvk9YFanXSWswsiJMFaACldcGn27qZ238czy8dDL8S8AXQlqtoEES5G0uGYKSf
	Ltn8nZQ1ziJrdsodb+Pu4ssbbr69g1jUrvqZF4HT9stwKGYaEcnHfVBQDp8E6/e6KvGOFcEjYw7
	knCoDh4IcfnvfSLCH+kL5LNVQ1yyQG4+cIkxsb4W17OYPqHBKg6uAIKEhU9T1g0G0cxZSL7Boeh
	K+jNNH+uVusFCLMIZsA+1wKB8BpJ9VRiKft7EwCBvS9KRpDe4OZKG2ZgGv/Qm3DQalAnCc/lo5O
	onu34vvGyQi25fQPNsOC4OvVA98onXgtIABBEZeqZh2me6uyetxnRDyB61YzJtB+CT0Ja4V2S+b
	YE/pPwLQ0DeVqJL+2GIpJUJ0wxcYsYz6W+LuqWT9Qa3PHpkmNDqAYh
X-Received: by 2002:a05:6214:252c:b0:8ac:74f5:fbaf with SMTP id 6a1803df08f44-8b3e31b8f6emr123930466d6.51.1777472481789;
        Wed, 29 Apr 2026 07:21:21 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3ef7ea763sm19052026d6.24.2026.04.29.07.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:21:21 -0700 (PDT)
Date: Wed, 29 Apr 2026 10:21:18 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Haowen Tu <tuhaowen@uniontech.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	laurent.pinchart@ideasonboard.com, hansg@kernel.org,
	mchehab@kernel.org, pavel@kernel.org, lenb@kernel.org,
	oneukum@suse.com, kernel@uniontech.com
Subject: Re: [RFC] USB/PM: should USB interface drivers distinguish
 hibernation THAW from RESTORE?
Message-ID: <37c9bf07-7b21-403c-b4fe-d54ff6f811db@rowland.harvard.edu>
References: <20260429033617.1954257-1-tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429033617.1954257-1-tuhaowen@uniontech.com>

On Wed, Apr 29, 2026 at 11:36:17AM +0800, Haowen Tu wrote:
> Hi,
> 
> I'm looking for feedback on a USB/PM design question that came up while
> investigating a UVC hibernation issue.
> 
> In the hibernation flow, after the memory snapshot has been created, the
> kernel briefly resumes devices in order to write the image to storage.
> On the successful hibernation path, the system is then powered off. For
> a USB camera that was actively streaming before hibernation, this means
> the USB resume path runs during that intermediate THAW phase, even
> though the final RESTORE path has not happened yet.
> 
> From the driver's point of view, that THAW phase is not semantically the
> same as the later RESTORE path after booting from the image.
> 
> The difficulty is that USB interface drivers currently get
> 
>     int (*suspend)(struct usb_interface *intf, pm_message_t message);
> 
> but resume-side callbacks are only
> 
>     int (*resume)(struct usb_interface *intf);
>     int (*reset_resume)(struct usb_interface *intf);
> 
> so by the time a USB interface driver's resume path runs, it has no
> direct way to distinguish a hibernation image-write THAW from the later
> RESTORE path.
> 
> The immediate trigger here is UVC, where resuming the streaming path
> during that THAW phase can turn the camera LED back on and cause other
> visible device activity even though the system is about to power off.

You don't know that.  As Oliver pointed out, if writing out the system's 
hibernation image fails, the system will not power off.

And anyway, what's wrong with turning the camera LED back on and 
performing other visible device activity during the THAW phase of 
hibernation?  If it helps, don't think of this as momentarily resuming 
activity during a shutdown -- instead think of the preceding FREEZE 
phase as momentarily pausing all activity while the system is still 
running.

Note that during the FREEZE phase, devices are not required to go to 
low power, just to stop transferring data.  It would be okay to leave 
the LED on during the FREEZE.

> More generally, review feedback on that patch was that solving this in
> individual leaf drivers would not scale well if other USB interface
> drivers ever need similar behavior.

It's not clear to me that anything needs to be solved.

> So the question is whether USB interface drivers should be able to
> distinguish these two phases, and if so, what the right interface would
> be.
> 
> Possible directions could include:
> 
>   1. Exposing the phase distinction to USB interface drivers
>   2. Handling it inside usbcore
>   3. Adding a USB-specific callback or other mechanism for this
>      transition
> 
> I'm intentionally not proposing a concrete API in this RFC yet. I'd
> first like to understand whether this should be considered a real USB PM
> interface issue, and if so, which direction would be the least
> intrusive and most maintainable.

Before anything gets changed, you should provide a good justification 
for changing it.

Alan Stern
