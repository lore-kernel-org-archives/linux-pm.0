From: Ian Malone <ibmalone@gmail.com>
Subject: Re: [PATCH REGRESSION FIX] x86 idle: restore mwait_idle()
Date: Sat, 14 Mar 2015 23:44:14 +0000
Message-ID: <CAL3-7MoEXfW0LTdQi3pakL+OaiKcVHPzPng142KKjCX66mNXDg@mail.gmail.com>
References: <1ae2a8af42281d6b9888ac8c76bab7bd2f431d44.1389763084.git.len.brown@intel.com>
	<345254a551eb5a6a866e048d7ab570fd2193aca4.1389763084.git.len.brown@intel.com>
	<52D8567A.8090308@mit.edu>
	<1389932442.5449.4.camel@marge.simpson.net>
	<1390037633.5676.3.camel@marge.simpson.net>
	<1390061684.5566.4.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38665 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbbCNXoQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 14 Mar 2015 19:44:16 -0400
In-Reply-To: <1390061684.5566.4.camel@marge.simpson.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Galbraith <bitbucket@online.de>
Cc: Andy Lutomirski <luto@amacapital.net>, Len Brown <lenb@kernel.org>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Josh Boyer <jwboyer@redhat.com>, stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>

On 18 January 2014 at 16:14, Mike Galbraith <bitbucket@online.de> wrote:
> On Sat, 2014-01-18 at 10:33 +0100, Mike Galbraith wrote:
>> On Fri, 2014-01-17 at 05:20 +0100, Mike Galbraith wrote:

> Signed-off-by: Mike Galbraith <bitbucket@online.de>
> Cc: <stable@vger.kernel.org> # 3.10+
> ---
>  arch/x86/kernel/process.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -427,18 +427,21 @@ static int prefer_mwait_c1_over_halt(con

Hi, this series of patches never seem to have made it as far as the
mainline kernel, anyone know what needs to happen next?

-- 
imalone
http://ibmalone.blogspot.co.uk
