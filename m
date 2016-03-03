From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] thermal: trace: migrating thermal traces to use
 TRACE_DEFINE_ENUM() macros
Date: Thu, 3 Mar 2016 12:28:24 -0500
Message-ID: <20160303122824.03f78705@gandalf.local.home>
References: <1456853934-24715-1-git-send-email-michele.digiorgio@arm.com>
	<20160301132006.1cda539c@gandalf.local.home>
	<56D87016.5030903@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:48370 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755097AbcCCR22 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2016 12:28:28 -0500
In-Reply-To: <56D87016.5030903@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michele DiGiorgio <michele.digiorgio@arm.com>
Cc: linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Javi Merino <javi.merino@arm.com>, linux-kernel@vger.kernel.org, Punit Agrawal <punit.agrawal@arm.com>, Eduardo Valentin <edubezval@gmail.com>

On Thu, 3 Mar 2016 17:10:46 +0000
Michele DiGiorgio <michele.digiorgio@arm.com> wrote:

> Hello Steven,
> 
> Thanks for acknowledging the patch.
> 
> Will you be merging it or should I refer to somebody else?
> 

It should go through the Thermal maintainer's tree.


-- Steve
