From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Sat, 1 Dec 2007 19:32:56 +0100
Message-ID: <20071201183256.GA14052@elte.hu>
References: <20071115181418.GA6603@ucw.cz> <473C825E.3030307@rtr.ca>
	<20071115193424.GA31691@elte.hu> <20071115193612.GA751@elte.hu>
	<20071130125628.GA30773@lazybastard.org>
	<20071130133546.GB29679@elte.hu> <20071130134312.GA32273@elte.hu>
	<20071130183510.GA1570@lazybastard.org>
	<20071130184625.GB9928@elte.hu>
	<20071201151650.GA5031@lazybastard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071201151650.GA5031@lazybastard.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@logfs.org>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, Mark Lord <liml@rtr.ca>, Mark Lord <lkml@rtr.ca>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* J=F6rn Engel <joern@logfs.org> wrote:

> > hm, that looks weird. if you disable CONFIG_PROVE_LOCKING, does that=20
> > improve things? (or just turns a noisy lockup into a silent lockup?)
>=20
> Not much, although the dumps look different now:
> http://logfs.org/~joern/trace3.jpg
> http://logfs.org/~joern/trace4.jpg
>=20
> I have to change my qemu setup a little to see the top of those=20
> dumps...

btw., if you start qemu like this:

qemu -cdrom ./cdrom.iso -hda ./hda.img -boot c -full-screen -kernel=20
~/bzImage -append "root=3D/dev/hda1 earlyprintk=3Dserial,ttyS0,9600=20
console=3Dtty console=3DttyS0,9600 enforcing=3D0 debug"

you'll get the inner kernel's serial console log to qemu's standard=20
output. Pretty useful for capturing kernel crashes.

	Ingo
