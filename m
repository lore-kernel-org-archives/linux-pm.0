From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Sun, 19 Dec 2010 12:00:06 +0200
Message-ID: <AANLkTi=AnsLbL4vfNC++CxVdP5hDMCxifXcQthYExQbH__16243.5068087236$1292752909$gmane$org@mail.gmail.com>
References: <AANLkTi=32bqipN5U00La-B7JSgTC1bHgMev=xUSF6kRN@mail.gmail.com>
	<Pine.LNX.4.44L0.1012181547580.7965-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1012181547580.7965-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Dec 18, 2010 at 11:20 PM, Alan Stern <stern@rowland.harvard.edu> wr=
ote:
>> They would also gain deterministic and controllable behavior that we
>> can't guarantee when we rely on a context switch, because obviously
>> the latter yields different results for different platforms and
>> workloads (for the exact same subsystem).
>
> Like I said before, it's a trade-off. =A0There are arguments for both
> sides, and which is better is unclear. =A0Rafael has to make a judgment
> call.

This calls for power measurements and analysis which may demonstrate
whether such a change is beneficial or not (and if yes, how much, and
under which workloads/setups).

Sadly I don't have the equipment to perform those measurements, which
I think are imperative to justify such a patch: IMHO the commit log
must include numbers...

Again, Rafael and Alan, thanks for your time and attention.

Ohad.
