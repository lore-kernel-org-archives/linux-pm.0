From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 09/13] PM: wakelock: Abort task freezing if a
	wake lock is held.
Date: Thu, 5 Feb 2009 02:08:39 -0800
Message-ID: <d6200be20902050208n398be36cre67791f5bc7b5be5@mail.gmail.com>
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
>> We should also check if we should abort after suspending any driver.
>> This was just the only place where the delay was noticeable since it
>> tries for 20 seconds.
>
> I still don't get it. Refrigerator freezes userspace processes, not
> devices.

Individual devices could also be slow to suspend, so aborting as soon
as you know that suspend will fail would be better. Right now I only
have two abort points, during freeze and a single late suspend
handler.

> Are you trying to improve hadling of suspend abort during freeze?

Yes.

-- =

Arve Hj=F8nnev=E5g
