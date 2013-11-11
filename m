From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC][PATCH v5 00/14] sched: packing tasks
Date: Mon, 11 Nov 2013 23:43:23 +0000
Message-ID: <C013CF72-36E2-450A-A91E-58522B465544@arm.com>
References: <1382097147-30088-1-git-send-email-vincent.guittot@linaro.org> <CAHkRjk69GNYtLGBSWCNcsCzkBHywKrD0qQQbNkJRpMbcdsCPyw@mail.gmail.com> <20131111165453.GB4586@e103034-lin> <20131111183142.GF29572@arm.com> <52812F6D.8090404@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:41473 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583Ab3KKXnk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2013 18:43:40 -0500
In-Reply-To: <52812F6D.8090404@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Morten Rasmussen <Morten.Rasmussen@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Paul Turner <pjt@google.com>, Chris Metcalf <cmetcalf@tilera.com>, Tony Luck <tony.luck@intel.com>, "alex.shi@intel.com" <alex.shi@intel.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, linaro-kernel <linaro-kernel@lists.linaro.org>, "len.brown@intel.com" <len.brown@intel.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul McKenney <paulmck@linux.vnet.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 11 Nov 2013, at 19:26, Arjan van de Ven <arjan@linux.intel.com> wrot=
e:
> On 11/11/2013 10:31 AM, Catalin Marinas wrote:
>> I agree, we can't rely on the requested C-state but the_actual_  sta=
te
>> and this means querying the hardware driver. Can we abstract this vi=
a
>> some interface which provides the cost of waking up a CPU? This coul=
d
>> take into account the state of the other CPUs in the cluster and the
>> scheduler is simply concerned with the wake-up costs.
>=20
> can you even query this without actually waking up the cpu and asking=
 ???

Even if you don=92t have additional hardware to query the state of a CP=
U
without waking it up, we could have a per-CPU variable storing the
actual C-states as selected by the arch backend.  This doesn=92t need t=
o
be precise but lets say only 90% accurate would probably be enough for
the scheduler.

Catalin