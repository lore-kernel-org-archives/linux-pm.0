From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 09/13] PM: wakelock: Abort task freezing if a
	wake lock is held.
Date: Thu, 5 Feb 2009 19:42:13 -0800
Message-ID: <d6200be20902051942h4500abffkdb0751488a4b6c3b@mail.gmail.com>
References: <1233802226-23386-5-git-send-email-arve@android.com>
	<1233802226-23386-7-git-send-email-arve@android.com>
	<1233802226-23386-8-git-send-email-arve@android.com>
	<1233802226-23386-9-git-send-email-arve@android.com>
	<1233802226-23386-10-git-send-email-arve@android.com>
	<20090205085531.GC2077@elf.ucw.cz>
	<d6200be20902050130q73d710foabb5d1a331f1528b@mail.gmail.com>
	<20090205094932.GL2077@elf.ucw.cz>
	<d6200be20902050158m7310bc60w8be16a3975535ee@mail.gmail.com>
	<20090205100217.GO2077@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090205100217.GO2077@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 5, 2009 at 2:02 AM, Pavel Machek <pavel@ucw.cz> wrote:
> ...so I guess I'll wait for extended description.
    PM: wakelock: Abort task freezing if a wakelock is locked.

    If a wakelock is locked, suspend will fail anyway. Since try_to_freeze_=
tasks
    can take up to 20 seconds to complete or fail, aborting as soon as some=
one
    locks a wakelock (e.g. from an interrupt handler) improves the worst ca=
se
    wakeup latency.

    On an older kernel where task freezing could fail for processes attached
    to a debugger, this fixed a problem where the device sometimes hung for
    20 seconds before the screen turned on.


-- =

Arve Hj=F8nnev=E5g
