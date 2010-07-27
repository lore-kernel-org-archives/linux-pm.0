From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Linux power managment for loadable kernel modules
Date: Tue, 27 Jul 2010 11:04:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1007271100350.1768-100000@iolanthe.rowland.org>
References: <2CC2A0A4A178534D93D5159BF3BCB661165B63D378@EAPEX1MAIL1.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <2CC2A0A4A178534D93D5159BF3BCB661165B63D378@EAPEX1MAIL1.st.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Divneil Rai WADHAWAN <divneil.wadhawan@st.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 27 Jul 2010, Divneil Rai WADHAWAN wrote:

> Hi,
> 
> I have started the work on Linux power management, and want to hook my loadable kernel modules to power management core of kernel.
> So, as a beginning point I have gone through the Linux Symposium section of Power management and gone through the code.
> I am using kernel 2.6.23.17 at present.

That's a pretty old kernel.  You should be using 2.6.34 or 2.6.35-rc 
for new development.

> Can you please confirm is the below method to use the device_suspend functionality from kernel correct?
> I am using the TTY as an example here.
> 
> tty_class = class_create(THIS_MODULE, "tty");
> struct device *dev= device_create(tty_class, NULL, MKDEV(TTYAUX_MAJOR, 0), "tty");
> dev->class->suspend=my_suspend_method;
> dev->class->resume =my_resume_method;
> 
> Is there any other way for doing that?

You probably shouldn't use TTY as an example, because there already is 
a TTY class driver (in recent kernels).  Try writing a regular driver 
instead of a class driver.

Alan Stern
