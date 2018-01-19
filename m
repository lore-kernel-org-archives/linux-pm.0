From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 3/4] drivers: qcom: rpmh-rsc: log RPMH requests in
 FTRACE
Date: Fri, 19 Jan 2018 09:44:43 -0500
Message-ID: <20180119094443.39e5f020@gandalf.local.home>
References: <20180119000157.7380-1-ilina@codeaurora.org>
        <20180119000157.7380-4-ilina@codeaurora.org>
        <20180118202607.3f40c238@gandalf.local.home>
        <20180119073501.GA26362@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180119073501.GA26362-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lina Iyer <ilina-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, 19 Jan 2018 07:35:01 +0000
Lina Iyer <ilina-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:

> Hi Steven,
> 
> On Thu, Jan 18 2018 at 01:26 +0000, Steven Rostedt wrote:
> >
> >I wasn't Cc'd on the rest of the patches and this wasn't Cc'd to LKML,
> >and I'm not on any of the mailing lists that were Cc'd, I gotta just
> >look at what I have here in this patch.
> >  
> I am so sorry. Will add LKML in the future.

Thanks. It's just that I had little context to review the patch from.


> >>  	struct rsc_drv *drv = (struct rsc_drv *)data;
> >>  	struct tcs_response *resp;
> >>  	unsigned long flags;
> >> -	int err;
> >> +	int err, m;
> >> +	struct tcs_mbox_msg *msg;
> >>
> >>  	do {
> >>  		spin_lock_irqsave(&drv->drv_lock, flags);
> >> @@ -364,7 +370,10 @@ static void tcs_notify_tx_done(unsigned long data)
> >>  		list_del(&resp->list);
> >>  		spin_unlock_irqrestore(&drv->drv_lock, flags);
> >>  		err = resp->err;
> >> +		m = resp->m;
> >> +		msg = resp->msg;
> >>  		free_response(resp);
> >> +		trace_rpmh_notify(drv->name, m, msg->payload[0].addr, err);  
> >
> >The reason I ask, is that this is causing more code to be executed
> >even when tracing is off. What about passing in resp and assigning it
> >within the tracepoint.
> >
> >	trace_rpmh_notify(drv->name, resp);
> >  
> The free_response(resp) will free the resp object and accessing resp->m
> is invalid after that.

What about placing the trace before the free?

-- Steve
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
