From: deepaksi <deepak.sikri@st.com>
Subject: SPEAR Power Management: Suspend to ram problem.
Date: Mon, 7 Mar 2011 13:18:32 +0530
Message-ID: <4D748DD0.4080608@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8305340448196069035=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Vipin KUMAR <vipin.kumar@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, Amit GOEL <amit.goel@st.com>, Armando VISCONTI <armando.visconti@st.com>, deepaksi <deepak.sikri@st.com>
List-Id: linux-pm@vger.kernel.org

--===============8305340448196069035==
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="content-type"
 content="text/html; charset=ISO-8859-1">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi,<br>
<br>
I am facing some issues related to system wake up&nbsp; from the sleep. The
SPEAr system is a SOC having the ARM cortex core.<br>
The system hardware has certain power islands, and one such island
contains the Memory controller. If all the power islands except for the
one with memory controller are switched off before moving into sleep,
the wake up and system restore happens fine. But once I switch off the
power island containing Memory Controller, we are facing certain issues
as soon as I re-enable the MMU. <br>
<br>
<br>
<b>Before Moving into sleep the following actions are performed.</b><br>
<br>
1. The code execution is done on the "Always on RAM". As the PC jumps
to Always on RAM, the contents of link register and GPR are latched on
to stack in DDR. Post this all the push operations are done on a
temporary stack maintained in Always on ram (AOR)<br>
2. Store sp and spsr to AOR<br>
3.&nbsp; Save all ARM registers: Coprocessor access control register, TTBR0,
TTBR1 and Translation table base control,&nbsp; Domain access control
register, data fault status register, instruction fault status
register,&nbsp; Data aux fault status register, instruction aux fault
status, data fault address register and instruction fault address
register,&nbsp; user r/w thread and process ID, user r/o thread and process
ID, priv only thread and process ID, cache size selection,&nbsp; Data TLB
lockdown, instruction TLB lockdown registers, Secure or non secure
vector base address, FCSE PID, Context PID, Primary remap, normal remap
registers, current cpsr, Data memory barrier and Data sync barrier...<br>
<br>
4. Switch off Instruction Cache, prediction flow, data cache. Then
Switch off the MMU, put the DDR is self refresh. <br>
5. Latch the memory controller initialization values on to stack<br>
5. Move the system into low power mode, and then switch off the power
domains.<br>
<br>
<b>Post wake up the actions are performed to restore in the reverse
order.</b> The values of the registers poped back is verified to be
fine.<br>
1. An additional step is to reset and reprogram the Memory controller
with the values latch on to the stack.<br>
<br>
When the MMU is re-enabled, the PC jumps fine to the Virtual address on
the "Always-on RAM". <br>
<br>
Then I pop the contents of link register, and GPR, from the stack. The
contents of these registers matched with the contents that were pushed
before moving into sleep (verification done). The DDR contents&nbsp; were
also verified to be correct for some random locations ( 0x0-0x8000)
before and after sleep, to ensure that the DDR corruption is not
triggering the problem. <br>
<br>
The last step involves programming the Program counter to a location on
DDR (latched in link register on DDR stack).<br>
But as soon as the Program Counter is programmed with the value of link
register (popped from DDR), the system gets a error, which I am not
able to trace using the lauterbach debugger.<br>
<br>
I suspect that there are still few things left in MMU configuration
(not sure), which I missed.<br>
The corruption problem could not be totally ruled out though as the
memory controller also moves to off state in system sleep, and then is
reset followed by DDR moved out of self refresh.<br>
<br>
I would really appreciate any help on this. <br>
<br>
Regards<br>
Deepak<br>
</body>
</html>

--===============8305340448196069035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8305340448196069035==--
