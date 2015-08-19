From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 3/5] gadget: Support for the usb charger framework
Date: Wed, 19 Aug 2015 15:56:36 +0300
Message-ID: <55D47D04.7060104@cogentembedded.com>
References: <cover.1439974219.git.baolin.wang@linaro.org>
 <59a5ba963dc2aaf9b1f59b0e79387b4d9ce3f30a.1439974219.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <59a5ba963dc2aaf9b1f59b0e79387b4d9ce3f30a.1439974219.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, sojka-Knnw/vAvyUalVyrhU4qvOw@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hello.

On 8/19/2015 12:13 PM, Baolin Wang wrote:

> For supporting the usb charger, it adds the usb_charger_init() and
> usb_charger_exit() functions for usb charger initialization and exit.
>
> Introduce a callback 'get_charger_type' which will implemented by
> user for usb gadget operations to get the usb charger type.
>
> Signed-off-by: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
[...]

> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index 755e8bc..44d82f5 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -537,6 +537,7 @@ struct usb_gadget_ops {
>   	struct usb_ep *(*match_ep)(struct usb_gadget *,
>   			struct usb_endpoint_descriptor *,
>   			struct usb_ss_ep_comp_descriptor *);
> +	enum usb_charger_type	(*get_charger_type)(struct usb_gadget *);
                              ^^^ please use space, not tab here

>   };
>
>   /**
> @@ -611,6 +612,7 @@ struct usb_gadget {
>   	struct usb_otg_caps		*otg_caps;
>   	struct raw_notifier_head	nh;
>   	struct mutex			lock;
> +	struct usb_charger		*uchger;

    Why not simply call the field 'charger'? :-)

[...]

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
