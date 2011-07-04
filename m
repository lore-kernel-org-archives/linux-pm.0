From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 3/7] fault-injection: notifier error injection
Date: Mon, 4 Jul 2011 14:35:04 +0900
Message-ID: <CAC5umyhKafTgUe6T2vfLupwmBwt5COj6X2nUH2b5ekhzQNi5mg__46937.9361290068$1309757841$gmane$org@mail.gmail.com>
References: <1309702581-16863-1-git-send-email-akinobu.mita@gmail.com>
	<1309702581-16863-4-git-send-email-akinobu.mita@gmail.com>
	<20110703171626.GG21127@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110703171626.GG21127@elf.ucw.cz>
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
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

2011/7/4 Pavel Machek <pavel@ucw.cz>:
>
>> + =A0 =A0 for (action =3D enb->actions; action->name; action++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct dentry *file =3D debugfs_create_int(act=
ion->name, mode,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 enb->dir, &action->error);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!file) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 debugfs_remove_recursive(enb->=
dir);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>
> Few lines how this work would be welcome...?

OK, I'll add a comment like below.

/*
 * Create debugfs r/w file containing action->error. If notifier call
 * chain is called with action->val, it will fail with the error code
 */
