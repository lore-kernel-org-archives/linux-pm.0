From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [GIT PULL] One more power management fix for 2.6.37
Date: Wed, 3 Nov 2010 22:18:55 +0100
Message-ID: <20101103211855.GA29721__36573.866432491$1288819387$gmane$org@isilmar-3.linta.de>
References: <201010292358.27975.rjw@sisk.pl>
	<AANLkTikF+8VsxyjmXUc_6Epd923g5DCxneNArFNTGrZ_@mail.gmail.com>
	<201011030356.13878.rjw@sisk.pl>
	<AANLkTikHRGkTGjBHQPt7-__XEWLYKLcSZgeXgicwOv8H@mail.gmail.com>
	<AANLkTikrDoKDWPMtSjJ0EjKXO7ddQZPkZ5ZvwoivkbnZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikrDoKDWPMtSjJ0EjKXO7ddQZPkZ5ZvwoivkbnZ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> There's apparently an ordering problem with dpm_list_mtx and
> socket->skt_mutex. Lockdep details appended.
> 
> Dominik, Rafael? What's the proper locking order here, and
> how do we fix this?

Thanks for noting this; let's see:

- We add a PCMCIA device holding skt_mutex, therefore we have the ordering
  (1) skt_mutex -> (2) dpm_list_mtx

- If we're suspending, dpm_list_mtx is held, but we need to acquire
  skt_mutex as we modify some data being protected by skt_mutex
  (1) dpm_list_mtx -> (2) skt_mutex

Rafael, any idea on how to solve this? How do other subsystems handle such
an issue? Do they call device_add() with no locks held at all?

Best,
	Dominik
