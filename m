From: Lina Iyer <ilina-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 3/4] drivers: qcom: rpmh-rsc: log RPMH requests in FTRACE
Date: Fri, 19 Jan 2018 16:17:33 +0000
Message-ID: <20180119161733.GA1851@codeaurora.org>
References: <20180119000157.7380-1-ilina@codeaurora.org>
 <20180119000157.7380-4-ilina@codeaurora.org>
 <20180118202607.3f40c238@gandalf.local.home>
 <20180119073501.GA26362@codeaurora.org>
 <20180119094443.39e5f020@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180119094443.39e5f020-f9ZlEuEWxVcJvu8Pb33WZ0EMvNT87kid@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Cc: andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 19 2018 at 14:44 +0000, Steven Rostedt wrote:
>On Fri, 19 Jan 2018 07:35:01 +0000
>Lina Iyer <ilina-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>
>> Hi Steven,
>>
>> On Thu, Jan 18 2018 at 01:26 +0000, Steven Rostedt wrote:
>> >
>> >	trace_rpmh_notify(drv->name, resp);
>> >
>> The free_response(resp) will free the resp object and accessing resp->m
>> is invalid after that.
>
>What about placing the trace before the free?
>
Sure. Will do that.

-- Lina

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
