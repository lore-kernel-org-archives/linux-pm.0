From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] power: fixup clock_ops
Date: Fri, 10 Jan 2014 16:23:56 +0000
Message-ID: <52D01E9C.2030302@codethink.co.uk>
References: <1389366360-7238-1-git-send-email-ben.dooks@codethink.co.uk> <CAMuHMdWSxxgq6dkng_RkJVPyPjODjs9G9Fn_J0GCG9M+RjNzfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([37.128.190.40]:35513 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbaAJQYS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2014 11:24:18 -0500
In-Reply-To: <CAMuHMdWSxxgq6dkng_RkJVPyPjODjs9G9Fn_J0GCG9M+RjNzfQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@lists.codethink.co.uk, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 10/01/14 15:59, Geert Uytterhoeven wrote:
> Hi Ben,
>
> On Fri, Jan 10, 2014 at 4:06 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> On the Renesas Lager board, this causes numerous warnings of the following
>> and even worse the clock system will not enable clocks, causing drivers
>> that are in development to fail to work:
>
> Did you see a message like
>
>      rcar_thermal e61f0000.thermal: thermal sensor was broken
>
> on Lager?

rcar_thermal e61f0000.thermal: 1 sensor probed 


but I've a few more fixes in flight due to other interesting issues...

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
