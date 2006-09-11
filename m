From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: community PM requirements/issues and PowerOP [Was: Re:
 So, what's the status on the recent patches here?]
Date: Mon, 11 Sep 2006 11:57:28 +0400
Message-ID: <450516E8.9010403@gmail.com>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.osdl.org>, scott.preece@motorola.com
List-Id: linux-pm@vger.kernel.org

Pavel,

Pavel Machek wrote:
 >
[snip]
 >> Are you arguing that the cpufreq interface be morphed to support power
 >> op applications?
 >
 > No. I'm arguing that
 >
 > * cpufreq interface should be used for changing cpu frequency
the patch set i sent out has cpufreq used for changing cpu frequency,
hasn't it?
 > * additional interfaces should be created for changing memory clock
 > etc.
the patch set I sent out allows to extend cpufreq interface to control
memory clock, etc by building all necessary additional pieces on top of
PowerOP Core layer which in conjunction with PM Core and clock/voltage
framework layers provides PM stack with well defined loosely coupled
interfaces between layers and PM functionality logically spread across
the layers instead if having everything mixed in one piece as cpufreq
does.
 > * existing interfaces should be used for turning devices on/off (and
 > new ones created when old ones do not exist)
PowerOP patch set for now is presenting just main basic block but
integration with devices suspend/resume, constraints, etc is next steps.
For now exactly existing interfaces for turning devices on/off may be used
in conjunction with poweop patch set although the interfaces may be
improved in the future if necessary
 > * powerop should take a look what userspace wants, and just close
 > closest point to that.
PowerOP is interface which allows wide range of interfaces to be built on
top of it including the interface you mentioned here. PowerOP/cpufreq
integration patch demonstrates this.

can we eventually start talking more close to the code rather than
speculating without it?

Pavel, if you feel that comments I put here don't correspond
to what my code is doing please show this by commenting the patch set
code.

Thanks,
	Eugeny
 > 							Pavel
 >
