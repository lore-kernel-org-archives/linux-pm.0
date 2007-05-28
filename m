From: power throwaway <turionpowerman@yahoo.com>
Subject: Turion 64 stop-grant question
Date: Sun, 27 May 2007 22:46:56 -0700 (PDT)
Message-ID: <735457.98582.qm@web59315.mail.re1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

I am building a low power system. I was looking at the
Turion 64 or Geode NX1750 processors. I remember that
with the original Athlon/Athlon XP, Linux was able to
adjust clock speed and power on the processors that
supported it, and would make idle calls when idle, but
could not put it in the stop-grant state when making
idle calls (which used a fraction of the power of
other modes). A number of utilities were released to
deal with the issue (athcool, coolrun, lvcool, fvcool,
etc.), but nothing supported a broad range of chipsets
(e.g. nothing for Ali Magick), and the results were
often unstable. 

I have not been able to figure out whether this was
still an issue for modern Athlon-64 based processors
like the Turion 64, or whether this has been resolved.


If anyone knows if how this is handled on mother
Turion processors with current Linux kernels, if you
could let me know, I would appreciate it. 

Background for those who are not familiar with
stop-grant: 

The stop-grant state powers down the bulk of the CPU,
but keeps IO open. If an interrupt comes in (the CPU
has work to do), the CPU wakes up and handles the
interrupt. It should be entered whenever the processor
is idle. Unfortunately, most older Athlon processors
and chipsets did not enter this mode when a cpu-idle
call was made. Windows and Linux also uses this state
in lieu of true suspend-to-memory for motherboards
that do not stably suspend to memory (in conjunction
with spinning down hard disks, powering down display,
and lowering power consumption on any other
peripherals where it could). 

This mode uses between 3 and 15 times less power than
the lowest P-state. The Turion 64 still uses 7.9 watts
idle in its minimum P-state, but only 2.2 watts in
stop-grant mode. Most of the other Athlon 64 chips use
19-36 watts in their lowest power P-state (clocked to
800MHz-1GHz, core voltage reduced to 1.1-1.3V), but
less than 3W in stop-grant. 

- Peter


       
____________________________________________________________________________________Be a better Heartthrob. Get better relationship answers from someone who knows. Yahoo! Answers - Check it out. 
http://answers.yahoo.com/dir/?link=list&sid=396545433
