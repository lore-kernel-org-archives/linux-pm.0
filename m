From: <rasmit.ranjan@wipro.com>
Subject: content of ../power/state file of usb device shows 2
	after suspend
Date: Thu, 21 Sep 2006 16:10:09 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB20286D803@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi,    =

    I face a problem while suspending any USB device through sysfs
interface.
I tried this with kernel 2.6.16.28. I tried the following thing
 =

echo -n 3 > /sys/bus/usb/devices/3-1.1.0/power/state
 =

After this when i display the content of the above file by
 =

cat /sys/bus/usb/3-1.1.0/power/state
 =

I get 2 not 3. But inspite of this the corresponding device interface
gets suspended properly.
 =

But this inconsistency does not happen with kernel 2.6.15.4. It seems
like now we need to echo 2 instead of 3 to suspend through sysfs
interface in 2.6.16. Is it true ? Please suggest
 =

Thanks,
Rasmit.
