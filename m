From: Guru Prasad <gurupras@buffalo.edu>
Subject: Disallow process from being scheduled for specific duration
Date: Mon, 30 Jun 2014 11:44:47 +0530
Message-ID: <CAMefCkAqpSb9x-uncxwr=7r0B-ms+w9M6X3DgV2rfe2in3NBYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:54806 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbaF3GOr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jun 2014 02:14:47 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-newbie@vger.kernel.org

Hi all,

First, I would like to establish that I'm fairly new to the scheduler
portion of kernel code.

I'm trying to implement a crude form of the rate limiting approaches
described in:
Currentcy - http://cseweb.ucsd.edu/~vahdat/papers/usenix03.pdf
Pixie - http://www.eecs.harvard.edu/~mdw/papers/pixie-sensys08.pdf

My current design is as follows ('task' refers to the current process'
task_struct):
    - I have augmented a hardware simulator(Gem5) with registers that
keep track of energy usage.
    - Upon every call to __schedule(), subtract the register value
from 'task->available_energy'
        - If 'task->available_energy' is negative:
            - Compute 'replenish_time' as time taken to replenish energy
            - Call schedule_timeout(msecs_to_jiffies(replenish_time))
        -  Reset energy registers

I'm primarily looking to disallow scheduling of the current task for
the period defined as 'replenish_time'.

I can see how it might be wrong to call schedule_timeout() from within
__schedule().
If so, what would be the right way of designing such a mechanism?


Regards
