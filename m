From: Adrian Fita <adrian.fita@gmail.com>
Subject: udev/power_supply battery oscilates between remove and
	add
Date: Wed, 25 Apr 2012 02:24:31 +0300
Message-ID: <4F97362F.9050909@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020400090804030400010803"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------020400090804030400010803
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi. I hope I'm addressing the appropriate mailinglist regarding this. If 
not, please direct me to the right place where I should write.

I'm using Debian Wheezy/Testing, kernel 3.2.15-1 on a HP PowerBook 4515s 
laptop.

I noticed that /var/log/syslog is getting spammed with messages like in 
the attached syslog-laptop-mode_spam.log.gz file.

Also, at the same time, "upower --monitor" shows the messages from 
upower-monitor.log.gz.

In Windows XP I don't see any issue with the battery and also running HP 
Battery Check 
(http://h20239.www2.hp.com/techcenter/battery/battery_ts.htm) I got the 
result that the battery is functioning correctly, but is week 
(admittedly it is more than a year old, but still holds a charge for 30 
mins).

So it looks like a kernel issue. I started checking the udev events with 
'udevadm monitor --property' and got the messages from the 
udevadm_monitor.log.gz file.

This happens only when the battery and the power cable are connected. 
When running with the battery removed or without the power cable 
connected (running only on battery) this is not happening.

Here are some more discussions about this:
- a Debian Bug reported: 
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=638970
- and also a thread on the Upower mailinglist: 
http://lists.freedesktop.org/archives/devkit-devel/2012-February/001225.html
-- 
Fita Adrian

--------------020400090804030400010803
Content-Type: application/x-gzip;
 name="syslog-laptop-mode_spam.log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="syslog-laptop-mode_spam.log.gz"

H4sICNqkkU8AA3N5c2xvZy1sYXB0b3AtbW9kZV9zcGFtLmxvZwBzLChSMDJQMDSwMjWyMjRR
qEotylfISSwoyS/Qzc1PSbVS8AFzFEAcLkeCqlPzEpNyUlN0iFCal1+ikJhcklmWqhBdmpec
kZiXnpoSS4TGAXWRsTEpLsKqGruLsCodmi4yNSLFRVhVY3cRVqVDxUUKXADX7LpFbQMAAA==
--------------020400090804030400010803
Content-Type: application/x-gzip;
 name="upower-monitor.log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="upower-monitor.log.gz"

H4sICPakkU8AA3Vwb3dlci1tb25pdG9yLmxvZwCt0zkOwjAQheGeU+QE3iaD7XRwAgqoEEIB
D4sQBDkRiNsTlgJaeK6tTzPy77k1FbvKkgqeFkV/klz2aymyHJuLpKrQTd7qTRZJ0h665qxn
k+YqWb/utXpVd53k23I8mprB/M2VylvzydUp/YV9zbbe1aftzxwrFyKOGyoXHY7zPWdxXOg5
g+MidFlyKlpcdUTKGwZV98Q8btUS+hDE0EwIGzE9Isb9WArQ6diqWDKsOnbKhwCq7oEB35UJ
Wh1jI2aGZsJD6J9gj1n2DleqFO5iBwAA
--------------020400090804030400010803
Content-Type: application/x-gzip;
 name="udevadm_monitor.log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="udevadm_monitor.log.gz"

H4sICPalkU8AA3VkZXZhZG1fbW9uaXRvci5sb2cA7dhBb5swFAfwO5+C43Zo84wNhkk+EOIm
qGAY4HbZFKEoQVvUNqnSrlG//Uyyagkl0tqpKwffLL8nG15+iv7JOc8Ej75ZxKXoFHsOWPbE
XFc3q4fK7M2rh8WsuutF4ks+zov4E8DvvXqVihQC8Ovl7WpTrcu7n7e314+9vl+A+WF/66Ph
B0WYCLY72Bjwi9QvRuwfLjDS5JJnZS7TNBqXwcjPhrw8k1HEEMIU4HhDOeB5OBSMEIBjfSK5
ZMjyWs6RWcZFsW1olsZBxMsgkaJolmJfyDM1ApnxjI2qzXV1f3+STmdX0/W80ZkMeFQKP+Ys
XS9upuvHw/q28vz904zn6rEYOtzOeRb66jgZ99XFAJhg0wLwemD3ULO38AuZM7m8Wq42y8Na
wYORSKJkOGbR4mSxapQvkqjw1dTiUDwNF4HbMt2nxt14iYvqjpx/Vg/IbOLYRi77tQMes/0P
3JAKTKmuZ9gwzhtgse1MzOl8/gZa1amaqqbaRtV5BVUXE2tizn5Ml9/f4rt1d7AGq8G2gaV/
A7Zem+YfsA6mOgxosJ0NAzLnQRmKsFAvFn7lA7aVq0IBRW5DMwHLAlcnBe24g0mh3TEBhMlz
x9Slno4RWnNnY8QxzdgBZz8Ue3BKEHHrUKwzhtb8Dprdl/2K24K1LZfqGKGp/meq3muo2o6j
k4IG+x5gKbzsD4cdWJcQHQY02M6GgbZo64FKsR5xmpotoI6tk4J23MGkcMSxBTaxmo6xTYHo
GKE1dzZGHNXsUWwavwAavVjN4iAAAA==
--------------020400090804030400010803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020400090804030400010803--
