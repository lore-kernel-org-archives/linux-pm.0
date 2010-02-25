From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: pm-suspend working, but pm-hibernate fails
Date: Thu, 25 Feb 2010 23:37:39 +0100
Message-ID: <201002252337.39683.rjw@sisk.pl>
References: <4B86F96A.1010306@maroy.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B86F96A.1010306@maroy.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?iso-8859-1?q?=C1kos_Mar=F3y?= <akos@maroy.hu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 25 February 2010, =C1kos Mar=F3y wrote:
> Hi,
> =

> I wonder how I could debug this issue: I have a system with pm-suspend
> working at last (see this thread: http://lkml.org/lkml/2010/2/23/62 for
> details), but pm-hibernate does not work. after issuing pm-hibernate, I
> see an empty screen with a blinking cursor on the top-left, and then
> nothing happens. the machine doesn't power off or anything.
> =

> forcing a power cycle leads me to a regular boot.
> =

> how could I debug this issue, to find out what fails?

Please try

# echo core > /sys/power/pm_test
# echo disk > /sys/power/state

That should return to the command prompt after ~5 sec.

Rafael
