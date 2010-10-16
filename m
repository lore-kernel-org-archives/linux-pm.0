From: Paul Stewart <pstew@google.com>
Subject: Re: [PATCH] ath9k: Convert to new PCI PM framework
Date: Fri, 15 Oct 2010 18:28:42 -0700
Message-ID: <AANLkTimXXERRCYEjzQbcii6XW8wbjNfN-eWigU7Wi_Lv__31810.432932298$1287417004$gmane$org@mail.gmail.com>
References: <201010160036.17653.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010160036.17653.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-wireless@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ath9k-devel@venema.h4ckr.net, "Luis R. Rodriguez" <lrodriguez@atheros.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 15, 2010 at 3:36 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> The ath9k driver uses the legacy PCI power management (suspend
> and resume) callbacks that apparently cause intermittent problems
> to happen (the adapter sometimes doesn't resume correctly on my
> Acer Ferrari One). =A0Make it use the new PCI PM and let the PCI core
> code handle the PCI-specific details of power transitions.
I'm curious.  What sort of behavior did you get when the device fails
to resume correctly?  Every now and then I've been getting bad
accesses to 0x7000 every now and then -- after that any reads to PCI
registers return all f's.

--
Paul
