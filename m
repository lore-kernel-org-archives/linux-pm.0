From: =?UTF-8?B?w4Frb3MgTWFyw7N5?= <akos@maroy.hu>
Subject: pm-suspend working, but pm-hibernate fails
Date: Thu, 25 Feb 2010 23:27:54 +0100
Message-ID: <4B86F96A.1010306@maroy.hu>
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

Hi,

I wonder how I could debug this issue: I have a system with pm-suspend
working at last (see this thread: http://lkml.org/lkml/2010/2/23/62 for
details), but pm-hibernate does not work. after issuing pm-hibernate, I
see an empty screen with a blinking cursor on the top-left, and then
nothing happens. the machine doesn't power off or anything.

forcing a power cycle leads me to a regular boot.

how could I debug this issue, to find out what fails?

this is on an HP Envy 15 laptop, and Ubunut 9.10, with a 2.6.32.8 kernel.


Akos
