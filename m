From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [10/11] use-case 4: Game on Android
Date: Fri, 20 Dec 2013 16:45:50 +0000
Message-ID: <1387557951-21750-11-git-send-email-morten.rasmussen@arm.com>
References: <1387557951-21750-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:59521 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755993Ab3LTQpk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2013 11:45:40 -0500
In-Reply-To: <1387557951-21750-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, markgross@thegnar.org, vincent.guittot@linaro.org, catalin.marinas@arm.com, morten.rasmussen@arm.com, linux-pm@vger.kernel.org

Games generally have periodic load pattern synchronized to the
frame-rate (30 or 60 Hz). Games workloads typically involve both
graphics rendering (game engine) and audio mixing.

Performance Criteria

Keep the frame-rate as close to the target as possible. Variations are
acceptable. Audio must be handled before the audio buffers runs empty.

Task behaviour

This description is based on one particular Android game, but similar
patterns have been observed for a number of games. Overall, 10+ threads
are active and context switches happen very often. Key game engine tasks
and graphics driver tasks are scheduled ~200-700 times per second. The
top 10 tasks (by cpu time) consists of: One game task, one main game
engine task, three graphics related tasks, three audio tasks, one event
handling task, and one kworker task.

Game engine task: By far the most cpu intensive task. Accounts for about
50% of all cpu load. It is scheduled ~375 times per second (average).
The scheduling pattern repeats every ~16 ms (~60 Hz), where the task
runs for ~12 ms, followed by three shorter periods of activity where the
longest is ~2 ms (unless it is preempted by other tasks). In addition,
the game engine has a worker thread for each cpu. Each of the worker
threads account for ~0.4% of the load, is scheduled ~115 times per
second (average), and only runs for ~56 us (average).

Rendering task: Accounts for ~6% of the load. Scheduled ~200 times per
second (average) and runs for ~420 us (average).

Graphics driver task: Accounts for ~6% of the load. Scheduled ~700 times
per second (average) and runs for 11 us (average).

Game main task: Accounts for ~4% of the load. Scheduled ~170 times per
second (average) and runs for ~37 us (average).

Audio system task: Accounts for ~3% of the load. Scheduled ~120 times
per second (average) and runs for ~42 us (average).

kworker task: Accounts for ~3% of the load. Scheduled ~320 times per
second (average) and runs for ~13 us (average).

