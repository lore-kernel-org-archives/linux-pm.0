From: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 5/6] ARM: STi: DT: STiH416: Supply Thermal Controller
 Device Tree nodes
Date: Mon, 21 Jul 2014 11:33:42 +0200
Message-ID: <53CCDE76.8060508@st.com>
References: <1401980819-19962-1-git-send-email-lee.jones@linaro.org> <1401980819-19962-6-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401980819-19962-6-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, ajitpal.singh-qxv4g6HH51o@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Lee,

On 06/05/2014 05:06 PM, Lee Jones wrote:
> We supply two of these.  The first is controlled by the System Configuration
> registers and the second one provided is a more traditional 'memory mapped'
> variant.  Each are handled by they own sub-driver.
>
> Signed-off-by: Ajit Pal Singh <ajitpal.singh-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>   arch/arm/boot/dts/stih416.dtsi | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>

Added to my queue for v3.17.

Thanks,
Maxime
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
