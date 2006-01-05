From: Greg KH <greg@kroah.com>
Subject: Re: [RFC/RFT][PATCH -mm 2/5] swsusp: userland interface
	(rev. 2)
Date: Wed, 4 Jan 2006 16:26:19 -0800
Message-ID: <20060105002619.GA16714@kroah.com>
References: <200601042340.42118.rjw@sisk.pl> <200601042351.58667.rjw@sisk.pl>
	<20060104234918.GA15983@kroah.com>
	<20060105001837.GA1751@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============89241318470922493=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060105001837.GA1751@elf.ucw.cz>
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
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============89241318470922493==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 05, 2006 at 01:18:37AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > +static int __init snapshot_dev_init(void)
> > > +{
> > > +	int error;
> > > +
> > > +	error =  alloc_chrdev_region(&interface.devno, 0, 1, interface.name);
> > > +	if (error)
> > > +		return error;
> > > +	cdev_init(&interface.cdev, &snapshot_fops);
> > > +	interface.cdev.ops = &snapshot_fops;
> > > +	error = cdev_add(&interface.cdev, interface.devno, 1);
> > > +	if (error)
> > > +		goto Unregister;
> > > +	error = sysfs_create_file(&power_subsys.kset.kobj, &snapshot_attr.attr);
> > 
> > Heh, that's a neat hack, register a sysfs file that contains the
> > major:minor (there is a function that will print that the correct way,
> > if you really want to do that), in sysfs.  It's better to just register
> > a misc character device with the name "snapshot", and then udev will
> > create your userspace node with the proper major:minor all automatically
> > for you.
> > 
> > Unless you want to turn these into syscalls :)
> 
> Well, I think we simply want to get static major/minor allocated for
> this device. It really uses read/write, IIRC, so no, I do not think we
> want to make it a syscall.

Ok, then I'd recommend using the misc device, dynamic for now, and
reserve one when you get a bit closer to merging into mainline.

thanks,

greg k-h

--===============89241318470922493==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============89241318470922493==--
