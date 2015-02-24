From: Tyler Hall <tylerwhall-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] thermal: armada: read stable temp on Armada XP
Date: Tue, 24 Feb 2015 14:56:12 -0500
Message-ID: <CAOjnSCaH5NtcYGdfQ+=XY9ZJtjYEEgLWKCGUeFXBsM1f+va-LA@mail.gmail.com>
References: <1423608615-6575-1-git-send-email-tylerwhall@gmail.com> <20150224183616.GD3448@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150224183616.GD3448-ld4jwAGwUXRveXEdyy5Li2QTnQI6vUnv7KzsFvvc4iU@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Eduardo,

On Tue, Feb 24, 2015 at 1:36 PM, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> The fix seams reasonable. Although, it remains the question what is
> applicability to other Armada chips? Besides, shouldn't we simply use it
> by default? Also, do you plan to send updates in the DTS files?

As far as I can tell, Armada 370 is already using the equivalent of
this register I'd like to use in Armada XP. I'm not sure about the
other mvebu platforms. I couldn't just change the device tree for XP
to instantiate the 370 sensor, however, as they have different
initialization routines. Possibly Eziquiel can comment on the
significance of the differences between armadaxp_init_sensor() and
armada370_init_sensor().

I would like to change the default going forward, but I don't think it
can be changed on platforms using an older DTB.

I had planned to submit the dts change separately. It's not clear to
me how that's supposed to be handled if they might go through
different trees.

Thanks,
Tyler
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
