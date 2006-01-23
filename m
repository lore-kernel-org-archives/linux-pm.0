From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm] swsusp: specify available swap in
	bytes
Date: Mon, 23 Jan 2006 11:34:54 +0100
Message-ID: <200601231134.55154.rjw@sisk.pl>
References: <200601221211.20937.rjw@sisk.pl> <20060122171447.GA1627@elf.ucw.cz>
	<20060123080953.GA22282@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060123080953.GA22282@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Stefan Seyfried <seife@suse.de>
Cc: Linux PM <linux-pm@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Monday, 23 January 2006 09:09, Stefan Seyfried wrote:
> On Sun, Jan 22, 2006 at 06:14:47PM +0100, Pavel Machek wrote:
> 
> > BTW that "make /sys/power/image_size be in bytes" perhaps should be
> > merged to Linus, so that 2.6.16 has final version of userland
> > interface. It is better to change it between -rc1 and final than
> > between 2.6.16 and 2.6.17.
> 
> Yes, ASAP please. I am integrating support for this in an userspace
> application right now (first try with large image_size, as large
> as free swap suggests; if this fails retry with image_size = 0)
> so it would be nice if this went in before 2.6.16

I'll do my best.

Greetings,
Rafael
