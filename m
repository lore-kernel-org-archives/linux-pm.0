From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: [RFC] Application of the Dynamic Voltage and Frequency
	Scaling on Real-Time Tasks
Date: Mon, 13 Aug 2007 16:39:47 -0400
Message-ID: <a0580c510708131339w6b912f6ekdd644aa94b803aaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: Raimundo Barreto <xbarretox@gmail.com>, =?ISO-8859-1?Q?Carlos_Augusto_de_Ara=FAjo_Mar?= <carlos.augusto.mar@gmail.com>, henry.vieira@nokia.com, David Cohen <david.cohen@indt.org.br>, Ilias Biris <ilias.biris@indt.org.br>
List-Id: linux-pm@vger.kernel.org

Hi all,

I'm a developer from INdT and a Master student from Department of Computer
Science at Universidade Federeal do Amazonas, Brazil.
Currently, I'm working in a project about Dynamic Voltage and Frequency
Scaling on Real-Time Tasks. So, I'd like to ask your
comments about our ideas regarding this project.


Title: Application of the Dynamic Voltage and Frequency Scaling on
Real-Time Tasks

Managing energy consumption has become vitally important to battery
operated portable and embedded systems. One of the Linux initiatives
for power management is CPUFreq. There are several tools, for
instance, PowerNowd and CPUSpeed, that dynamically control CPU
frequency (adopting CPUFreq), slowing down the CPU to conserve power
and reduce heat but only when the system is idle. However, at the best
of our present knowledge, there is no initiative to carry out power
control inside an individual task boundary.

The energy consumption has a quadratic dependency on supply voltage
Vdd. Furthermore, lowering Vdd is the most effective way of reducing
energy consumption. However, lowering the supply voltage also
decreases the clock frequency. We know that when a given task's
required performance is lower than the processor maximum performance,
the supply voltage (and its corresponding clock frequency) can be
dynamically controlled to the lowest possible level while meeting the
task's timing constraints. This power/energy management technique is
called Dynamic Voltage and Frequency Scaling (DVFS). Such technique
reduces the processor's energy consumption quadratically at the
expense of linearly decreasing the performance. Reducing energy using
DVFS in the context of real-time systems should consider this
tradeoff.

There are some problems in applying the above proposal. The first one
is that there are no systematic guidelines for selecting the best
program locations for inserting voltage-scaling code. Secondly,
average programmers are generally not familiar with low-energy
software issues and timing analysis techniques. Lastly, the
application of intra-task voltage scheduling is responsibility of such
programmers. In practice, the adoption of intra-task voltage
scheduling for real-time applications is very difficult without the
support of a systematic programming methodology.

What we are proposing is a tool that receives as input a C program
code (P) and returns an equivalent C program code (Pdvfs) with lower
energy consumption through DVFS technique. The proposed strategy
performs a static execution-time analysis of the source C program for
selecting locations where to insert voltage-scaling code in order to
reduce the overall energy consumption and, at the same time, meeting
deadlines.

The advantages of this strategy can be depicted as follows: (1) It
exploits all the slack time from runtime variations of different
execution paths, where the intention is not having any slack time; (2)
The voltage-scaling decisions are performed at compile time; (3) We
can provide a systematic methodology for developing an automatic
program conversion tool to convert DFVS-unaware programs into
DFVS-aware ones; (4) Starting from such methodology, programmers need
not to know about DVFS.

The summary of the proposed method is as follows:

* The input program code P is translated to a control-flow graph Gp,
where each node represents a basic block of P; and each edge indicates
the control dependency between basic blocks. Inside each node there is
the amount of processor cycles of this basic block;

* Analysis of the control-flow graph to determine the worst-case
execution path (WCEP). The initial clock frequency should be set in
such a way that the WCEP can be reached at the task's deadline;

* Include in the control-flow graph the Crwec(bi), which represents
the remaining worst-case execution cycles (RWEC) among all the
execution paths that start from basic block bi. Starting from
Crwec(bi) we may identify all short execution paths in the early phase
of execution, and so, we can lower the voltage and processor
frequency. In other words, if there is an edge where the remaining
worst-case execution cycle is reduced faster than the current
execution rate, this edge should be considered to include
voltage-scaling code;

* Change the original program source code  by inserting (in
appropriated places as detailed in previous item) voltage/frequency
code scaling. Obviously, calculations should be performed in order to
guarantee that using the new voltage/frequency the remaining
worst-case execution cycles can be completed at the deadline;

Suppose the control-flow graph depicted by the picture in:
http://www.dcc.ufam.edu.br/~ebv/controlflowgraph.gif

Considering such graph, the calculations are divided into two categories:

1. Voltage Scalling Edge Type B (VSE TYPE B) is calculated by the
following equation:

 r(bi --> bj) =  Crwec (bj) / (Crwec [succ(bi)] - CoverheadB)

Where,

r(bi --> bj) -- is called speed (frequency) update ratio when
execution path go from bi to bj. It is the ratio in which the
frequency will be reduced.

Crwec [succ(bi)] -- is basic block bk, an immediate successor of bi
with the largest Crwec(bk) among all successors.

For example, suppose bi = b1 and bj = b2. Program starts from b1 and
follow by b2, so in this path is possible to change the frequency
because it is not in the WCEP. Crwec [succ(bi)], in this case,  is the
block bk with the largest Crwec(bk) among all b1's successors. Among
all b1's sucessors (b2 and bwh) bwh is the block wich the largest
Crwec.

CoverheadB -- denotes the number of cycles needed to execute the
instructions that change the frequency and voltage.

2.Voltage Scalling Edge Type L (VSE TYPE L) is calculated by the
following equations:

S(bif) = S(bwh)*Crwec(bif)/(Crwec(bif) + Csaved (L) - CoverheadL)

Csaved(L) = Cwcec(L)*[Nworst(L) - Nexec(L)]


Where,

S(bwh) - is the frequency at block bwh.

Csaved(L) - is the saved cycles for loop L.

Cwcec(L) - is the worst-case number of execution cycles to execute loop L once.

Nworst(L) - is the user-provided maximum number of loops for loop L.

Nexec(L) - is the number of actual loop iterations measured at runtime.

CoverheadL - denotes the number of cycles need to execute the
instructions that change the frequency and voltage.

In order to the method to be successful there is the need of several tools:
* Processor cycles estimator of basic blocks;
* Translator from the source program to control-flow graph;
* WCEP generation of a control-flow graph;
* Generation of the RWEC of basic blocks in the control-flow graph;
* Code transformation from P to PDVFS.

Initially, we have implemented the proposal adopting the following assumptions:
* ARM-9 processor;
* Non-preemptive tasks;
* Deadline of tasks are well-known;
* There is an estimator to the amount of loop interactions.

Most of such tools are already implemented and can be seen at
http://osmrc.indt.org/cgi-bin/gitweb.cgi . Those repositories can be
cloned with the following commands:

* for the graph generator and tools to generate WCEP and RWEC:
# git  clone http://osmrc.indt.org/git/graphgen.git

* for the library:
# git  clone http://osmrc.indt.org/git/library.git

* for the code manipulation tool  (Code transformation):
# git  clone http://osmrc.indt.org/git/translator.git

* and for test cases:
# git  clone http://osmrc.indt.org/git/tests.git


Bibliography
Dongkun Shin, Jihong Kim, e Seongsoo Lee. Intra-Task Voltage
Scheduling for Low-Energy Hard Real-Time Applications. IEEE Design and
Test of Computers. 18(2). pp 20-30. 2001.

BR,

-- 
Eduardo Bezerra Valentin
INdT - OSMRC - Manaus
Core team
