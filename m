From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 0/2] Freezer fixes for 2.6.24
Date: Thu, 22 Nov 2007 14:05:41 +0100
Message-ID: <47457EA5.60302@gmail.com>
References: <200711210244.37965.rjw@sisk.pl> <4743E38D.60205@gmail.com>
	<200711212021.51968.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711212021.51968.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Wednesday, 21 of November 2007, Franck Bui-Huu wrote:
>> Rafael J. Wysocki wrote:
>>> The second one is intended to fix the APM emulation breakage caused before
>>> 2.6.23, but unfortunately I can't test it.
>> Why not ?
>>
>> Just hack Kconfig to be able to select this driver on x86 architecture
>> and it should work fine, no ?
> 
> Well, I'm afraid I have no suitable userland here ...
> 

I don't have either.

Anyway I just verified that the current code is broken. I put 2
processes waiting for a suspend evetn by reading the /dev/apm_bios
device and a third process that does the suspend event by doing an
ioctl() on the apm device. The system doesn't suspend (the kernel
dumped a list of the current tasks, instead of printing "Freezing of
tasks failed after..." BTW) and eventually the third process exits
with an incorrect value: -EINTR.

Applying your patch makes the previous test case work.

I also discovered that s2ram doesn't work on my laptop and had to use
standby suspend. I'll try to find out why.

		Franck
