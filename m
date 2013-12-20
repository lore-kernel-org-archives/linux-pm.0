From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [8/11] use-case 2: Audio playback on Android
Date: Fri, 20 Dec 2013 16:45:48 +0000
Message-ID: <1387557951-21750-9-git-send-email-morten.rasmussen@arm.com>
References: <1387557951-21750-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:59464 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573Ab3LTQpj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2013 11:45:39 -0500
In-Reply-To: <1387557951-21750-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, markgross@thegnar.org, vincent.guittot@linaro.org, catalin.marinas@arm.com, morten.rasmussen@arm.com, linux-pm@vger.kernel.org

Audio playback is a low load periodic application that has little/no
variation in period and load over time. It consists of tasks involved in
decoding the audio stream and communicating with audio frameworks and
drivers.

Performance Criteria

All tasks must have completed before the next request to fill the audio
buffer. Most modern hardware should be able to deal with the load even
at the lowest P-state.

Task behaviour

The task load pattern period is dictated by the audio interrupt. On an
example modern ARM based system this occurs every ~6 ms. The decoding
work is triggered every fourth interrupt, i.e. a ~24 ms period. No tasks
are scheduled at the intermediate interrupts. The tasks involved are:

Main audio framework task (AudioOut): The first task to be scheduled
after the interrupt and continues running until decoding has completed.
That is ~5 ms. Runs at nice=3D-19.

Audio framework task 2 (AudioTrack): Woken up by the main task ~250-300
us after the main audio task is scheduled. Runs for ~300 us at nice=3D-16.

Decoder task (mp3.decoder): Woken up by the audio task 2 when that
finishes (serialized). Runs for ~1 ms until it wakes a third Android
task on which it blocks and continues for another ~150 us afterwards
(serialized). Runs at nice=3D-2.

Android task 3 (OMXCallbackDisp): Woken by decoder task. Runs for ~300
us at nice=3D-2.


