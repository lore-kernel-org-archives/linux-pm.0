From: Mike Galbraith <efault@gmx.de>
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and
 clock BOOTTIME
Date: Thu, 26 Apr 2018 09:03:56 +0200
Message-ID: <1524726236.7572.1.camel@gmx.de>
References: <CANq1E4QppGAaU5PYbGpuC00S6wGQcAt70Z7CntZHiLC6748z2A@mail.gmail.com>
         <alpine.DEB.2.21.1804241007410.5261@nanos.tec.linutronix.de>
         <1996930.B4PaKZ6i1F@aspire.rjw.lan> <1858767.c2KKoU8fl2@aspire.rjw.lan>
         <alpine.DEB.2.21.1804251502310.2082@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1804251502310.2082@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: John Stultz <john.stultz@linaro.org>, Genki Sky <sky@genki.is>, David Herrmann <dh.herrmann@gmail.com>, lkml <linux-kernel@vger.kernel.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2018-04-25 at 15:03 +0200, Thomas Gleixner wrote:
> Right, it does not matter. The real interesting one is d6ed449afdb3.

FWIW, three boxen here suspend/resume fine, but repeatably exhibit the
below after a very few minute suspend, and a short bisect fingered your
suspect.  Distro is opensuse 42.3.

[  211.113902] Restarting tasks ... done.
[  211.114817] PM: suspend exit
[  212.312993] systemd-journald[7266]: File /var/log/journal/016627c3c4784cd4812d4b7e96a34226/system.journal corrupted or uncleanly shut down, renaming and replacing.
[  212.313363] systemd-coredump[7264]: Detected coredump of the journal daemon itself, diverted to /var/lib/systemd/coredump/core.systemd-journal.0.0aa39276decf4f1ab6fda3464e31f9dd.582.1524720954000000.
