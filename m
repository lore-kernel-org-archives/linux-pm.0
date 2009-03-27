From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: additional hibernation notifier
Date: Fri, 27 Mar 2009 12:37:40 +0100
Message-ID: <1238153860.9458.74.camel@braunu-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Working on the s390-part of the Linux kernel, I am currently starting to
look at hibernation. We have components without associated devices that
are supposed to do something for hibernation, once the processes are
freed. Thus they need a notification. Looking at kernel/power/disk.c the
available notification PM_HIBERNATION_PREPARE is done before the
prepare_processes() call. This does not fit to our needs. We would like
to see a notification after prepare_processes() somewhere at the time of
the device_suspend() call. In linux-pm I found that more notifiers have
been discussed in the past, but are not added without any users.

Do we have a chance to get additional hibernation notifiers, if we are
exploiting them in our s390-code?
 
Kind regards,
Ursula Braun
