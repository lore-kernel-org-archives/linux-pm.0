From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: swsusp regression [Was: 2.6.17-mm1]
Date: Thu, 22 Jun 2006 22:37:42 +0159
Message-ID: <449AFFAD.2030601@gmail.com>
References: <Pine.LNX.4.44L0.0606221505030.5772-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0606221505030.5772-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

Alan Stern napsal(a):
>> Ok, the problem is in verify_suspended(), we are not detecting what type
>> of device this is.
>>
>> Alan, what are you trying to check for here?  What "bogus requests" were
>> you seeing from sysfs that you are trying to filter out?
> =

> I didn't write that routine, Dave Brownell did.  It has been there for
> ages.  The "bogus requests" are attempts by the user to suspend a USB
> device (by writing to /sys/devices/.../power/state) without first
> suspending all its children and interfaces.
> =

> (This can't happen when doing a global suspend because the PM core =

> iterates through the entire device tree.  It matters only for "runtime" o=
r =

> "selective" suspend.)

But everything I did is:
echo reboot > /sys/power/disk
echo disk > /sys/power/state

No writing anywhere else.

regards,
-- =

Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
