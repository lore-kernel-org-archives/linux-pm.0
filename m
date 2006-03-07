From: Tehn Yit Chin <tehn-yit.chin@greyinnovation.com>
Subject: apm for individual devices
Date: Tue, 07 Mar 2006 11:44:35 +1100
Message-ID: <440CD773.6010401@greyinnovation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi all,

How does one use the sysfs entry of power/state that I can find for each 
registered device? Eg, for the i2c device on my s3c2410 cpu, I find the 
following entry,

/sys/devices/platform/s3c2410-i2c/power/state

I tried echoing "mem" into it, but nothing seems to happen.

What I am looking for is a way of suspending and resuming individual 
devices within the PM architecture?

Any pointers would be greatly appreciated.
-- 
Tehn Yit Chin
Software Engineer, Grey Innovation Pty. Ltd.
