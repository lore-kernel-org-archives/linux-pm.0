From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v3 21/22] cpufreq: add support for CPU DVFS based on SCMI
 message protocol
Date: Wed, 4 Oct 2017 13:30:06 +0200
Message-ID: <CAK8P3a3pAFKM+Dq_yb7KYhB+xeneVuODBq_4nacEuw9creT6Yw@mail.gmail.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com> <1506604306-20739-22-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1506604306-20739-22-git-send-email-sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Cc: ALKML <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Roy Franz <roy.franz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Harb Abdulhamid <harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>, Alexey Klimov <alexey.klimov-5wv7dgnIgG8@public.gmane.org>, Ryan Harkin <Ryan.Harkin-5wv7dgnIgG8@public.gmane.org>, Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

> +static int scmi_cpufreq_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +
> +       handle = devm_scmi_handle_get(&pdev->dev);
> +
> +       if (IS_ERR_OR_NULL(handle) || !handle->perf_ops)
> +               return -EPROBE_DEFER;

As mentioned before, never create an interface that needs to use
IS_ERR_OR_NULL(), make it return either NULL on error, or always
have an error code.

> +
> +static struct platform_driver scmi_cpufreq_platdrv = {
> +       .driver = {
> +               .name   = "scmi-cpufreq",
> +       },
> +       .probe          = scmi_cpufreq_probe,
> +       .remove         = scmi_cpufreq_remove,
> +};

You appear to have split this driver into the 'cpufreq' side and
the 'protocol' handler in a different file. I already commented that
the way the main scmi driver knows about all the protocols looks
bad, here we can see another aspect of the same problem.

Rather than manually register a platform_device for the purpose
of connecting it to the cpufreq driver, there should be a way
to dynamically register the protocol from the cpufreq driver
and then have both in the same file.

      Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
