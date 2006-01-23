From: Stefan Seyfried <seife@suse.de>
Subject: Re: [RFC][PATCH -mm] swsusp: specify available swap in
	bytes
Date: Mon, 23 Jan 2006 09:09:53 +0100
Message-ID: <20060123080953.GA22282@suse.de>
References: <200601221211.20937.rjw@sisk.pl> <20060122171447.GA1627@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060122171447.GA1627@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Jan 22, 2006 at 06:14:47PM +0100, Pavel Machek wrote:

> BTW that "make /sys/power/image_size be in bytes" perhaps should be
> merged to Linus, so that 2.6.16 has final version of userland
> interface. It is better to change it between -rc1 and final than
> between 2.6.16 and 2.6.17.

Yes, ASAP please. I am integrating support for this in an userspace
application right now (first try with large image_size, as large
as free swap suggests; if this fails retry with image_size =3D 0)
so it would be nice if this went in before 2.6.16
--=20
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, N=FCrnberg \                    -- Leonard Cohe=
n
