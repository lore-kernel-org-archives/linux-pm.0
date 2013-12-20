From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [9/11] use-case 3: Video playback on Android
Date: Fri, 20 Dec 2013 16:45:49 +0000
Message-ID: <1387557951-21750-10-git-send-email-morten.rasmussen@arm.com>
References: <1387557951-21750-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:59485 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040Ab3LTQpj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2013 11:45:39 -0500
In-Reply-To: <1387557951-21750-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, markgross@thegnar.org, vincent.guittot@linaro.org, catalin.marinas@arm.com, morten.rasmussen@arm.com, linux-pm@vger.kernel.org

Depending on the platform hardware video is a low to medium load
periodic application. There may be some variation in the load depending
on the video codec, content, and resolution. The load pattern is roughly
synchronized to the video frame-rate (typically 30 FPS). Video playback
also includes audio playback as part of the workload.

Performance Criteria

Video decoding must be done in time to avoid dropped frames. Similarly,
audio must be decoded in time to never let the audio buffer run empty.

Task behaviour

Based on video playback (720p and 1080p) on a modern ARM SoC, the cpu
load is generally modest. Video resolution has only a minor impact on
the overall cpu load. The load pattern is repeating every ~33 ms.

Rendering task: The main Android graphics rendering task accounts for
about 18% of the total cpu load. It is active for about ~6-8 ms each
period during which it is blocking a couple of times. It appears to run
in sync with a handful of other tasks. Most of which are related to
timed queues in Android and graphics.

Timed events queue tasks: An Android TimedEventQueue task for each cpu
is active during video playback. In total, they account for around 30%
of the cpu load. They are all following the 33 ms period and run for
250-700 us when scheduled (average).

Audio decoding task: Accounts for ~10% of the cpu load. Load pattern
repeat every ~23 ms. Since this is different from the period of video
rendering, this may run in parallel with video rendering form time to
time. Audio decoding runs for about 2 ms when scheduled each period.

A lot of smaller tasks are involved in the periodic load pattern.

