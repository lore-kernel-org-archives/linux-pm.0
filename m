From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] cpuidle/idle: move idle traces to cpuidle_enter_state
Date: Mon, 14 Jul 2014 17:00:16 -0400
Message-ID: <20140714170016.62d9fddd@gandalf.local.home>
References: <1404293458-9799-1-git-send-email-sandeep.tripathy@linaro.org>
	<53B81D94.6000404@linaro.org>
	<1602555.3nqafCzk86@vostro.rjw.lan>
	<20140714200716.GQ9918@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.229]:65166 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757251AbaGNVAS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jul 2014 17:00:18 -0400
In-Reply-To: <20140714200716.GQ9918@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Sandeep Tripathy <sandeep.tripathy@linaro.org>, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org

On Mon, 14 Jul 2014 22:07:16 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> And I suppose the 'assumption' is that the target_state->enter()
> function does not entail 'tracing' ? Is it made sure that these
> functions do not generate __mcount or other function tracer stubs etc. ?

Lets not confuse events with function tracing. Function tracing has its
own infrastructure and is made to trace details of things like
target_state->enter() and such. And function tracing can trace even
outside of rcu scope, which trace events do not.

When people want to trace events, that assumption is just trace events,
not function tracing.

-- Steve

