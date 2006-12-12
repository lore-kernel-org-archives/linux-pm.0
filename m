From: Brice Goglin <brice@myri.com>
Subject: /sys/devices/.../power/state broken?
Date: Tue, 12 Dec 2006 11:17:11 +0100
Message-ID: <457E81A7.4080601@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: pavel@suse.cz, Greg KH <gregkh@suse.de>, David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi,

I know that .../power/state files are deprecated, but I like using them
for basic testing of a driver's suspend/resume routines. Anyway, echoing
something in the .../power/state in current -git does not seem to work
anymore. For instance, the driver's suspend routine is not called
anymore  when writing 3 while it was at least in 2.6.17 and 2.6.18. And
reading the contents of the file afterwards now returns 0 while it
seemed to return 2 before.

I didn't have time to git-bisect the problem so far, I will if nobody
has any idea.

And if somebody knows what to use instead of .../power/state to test a
driver's suspend/resume, I'd be happy to hear it too. The explanation in
feature-removal-schedule.txt did not help a lot, neither did the thread
I found on linux-pm :)

thanks,
Brice
