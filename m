From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] Suspend to disk with PCMCIA card
	plugged in with kernel 2.6.16.28
Date: Thu, 19 Oct 2006 14:10:31 -0700
Message-ID: <200610191410.31802.david-b@pacbell.net>
References: <380D9721A8E2114485644D71E87C6AB202902D60@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <380D9721A8E2114485644D71E87C6AB202902D60@PNE-HJN-MBX01.wipro.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: linux-usb-devel@lists.sourceforge.net
Cc: deepti.chotai@wipro.com, rasmit.ranjan@wipro.com, linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

On Monday 02 October 2006 10:50 pm, rasmit.ranjan@wipro.com wrote:
> 

> > > 4. Now again going a step ahead. I plugged in my PCMCIA 
> > > card, then I 
> > > connected a USB speaker to the USB port of the card and started 
> > > playing a song. Now I suspended the system to disk while 
> > > the transfer 
> > > was in progress( song was being played). But this time my system 
> > > hangs. This happens with other isochronous devices like webcam and 
> > > bulk device like USB key as well. So suspend to disk fails 
> > > if any USB 
> > > transfer is in progress ( through the USB port of my PCMCIA card).

Sounds like those drivers need to learn how to handle USB suspend
operations ... there are quite a few drivers which don't even have
basic suspend() and resume() calls.

ISTR a while back the kernel would refuse to suspend when faced with
such devices, which meant users would be forced to Do The Right Thing
and disconnect them before suspending ... but that behavior was then
changed, producing this dangerous behavior (hanging).

Me, I prefer nice clean failures like "can't suspend, you have to
unplug the devices with broken drivers" rather than nasty ones like
the hang you referenced.

I'd suggest that you look at providing patches for those drivers
which don't provide suspend() and resume() methods ...


> > > I tried debugging the problem and used kdb to find out the 
> > reason. For 
> > > all the devices I found out the following thing :
> > > 
> > > The system hangs in following path: usb_disconnect --> 
> > > usb_disable_device --> put_device.
> > > After put_device the system hangs. As I was in kdb mode I could not 
> > > save the stack trace.

You need to learn about "serial consoles" then.  ;)


 
> > > Is it a known kernel problem with 2.6.16.28 ? Please suggest.
> > 
> > Reproduce it with 2.6.18, then it is bugzilla time, or post 
> > to linux-usb mailing list.
> 
> Thanks Pavel. I tried with kernel 2.6.18. It worked fine with bulk
> device ( USB key). But does not work with isochronous device and system
> hangs. This time I did not have kdb so could not figure out where did it
> hang.
> Is it that for 2.6.16.28, this path is still broken for some cases like
> suspend to disk when transfer is in progress??

If any driver does not stop its I/O when suspend-to-disk starts, that's
a bug in that driver.

- Dave



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
