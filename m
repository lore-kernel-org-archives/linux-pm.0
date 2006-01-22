From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm] swsusp: specify available swap in
	bytes
Date: Sun, 22 Jan 2006 18:14:47 +0100
Message-ID: <20060122171447.GA1627@elf.ucw.cz>
References: <200601221211.20937.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============91130730020003092=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200601221211.20937.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============91130730020003092==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Ne 22-01-06 12:11:20, Rafael J. Wysocki wrote:
> Hi,
> 
> If the SNAPSHOT_AVAIL_SWAP ioctl returns the number of bytes, it will allow us
> to use the number as an input for the SNAPSHOT_SET_IMAGE_SIZE ioctl directly.
> 
> OTOH, to make SNAPSHOT_AVAIL_SWAP return the number of bytes we need to
> add the size of the image in bytes to the image header, but this really costs us
> nothing, because the header is page-aligned anyway.
> 
> The appended patch contains all the necessary changes.
> 
> Opinions welcome. :-)

ACK.

BTW that "make /sys/power/image_size be in bytes" perhaps should be
merged to Linus, so that 2.6.16 has final version of userland
interface. It is better to change it between -rc1 and final than
between 2.6.16 and 2.6.17.

Thanks,
								Pavel

-- 
Thanks, Sharp!

--===============91130730020003092==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============91130730020003092==--
