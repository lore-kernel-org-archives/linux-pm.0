From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 5/7] thermal: add trace events to the power allocator
 governor
Date: Thu, 26 Feb 2015 14:38:45 -0500
Message-ID: <20150226143845.67e00224@gandalf.local.home>
References: <1424977233-15965-1-git-send-email-javi.merino@arm.com>
	<1424977233-15965-6-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0128.hostedemail.com ([216.40.44.128]:33929 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753882AbbBZTis (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Feb 2015 14:38:48 -0500
In-Reply-To: <1424977233-15965-6-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, broonie@kernel.org, tixy@linaro.org, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>

On Thu, 26 Feb 2015 19:00:31 +0000
Javi Merino <javi.merino@arm.com> wrote:

> Add trace events for the power allocator governor and the power actor
> interface of the cpu cooling device.

For the tracing parts...

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> ---
