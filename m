From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 0/3] thermal: broadcom: complete and extend to NSP
Date: Thu, 23 Mar 2017 20:21:57 +0100
Message-ID: <CACna6rwPAwMrrocNMbNko6iMhz+3BqGGrZdEgY1hBKrBisGu3g@mail.gmail.com>
References: <1490296728-14733-1-git-send-email-jon.mason@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490296728-14733-1-git-send-email-jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 23 March 2017 at 20:18, Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
> This patch series is intended to complete the implementation submitted
> in http://www.spinics.net/lists/devicetree/msg168813.html
> It lacked the Kconfig select options and DT bindings for BCM5301X.
> Also, it did not allow for NSP to be selected.  This series addresses
> that.
>
> I'm sending this as an RFC, as that series has not been included (or
> reviewed) yet.  If Rafal wants to include these in a v2 of his series,
> then I am agreeable with that.

This sounds great, but I think dts changes should go through separated
(Florian's) tree. So my plan is to combine my patch with your 1/3.

Does it sound OK to you?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
