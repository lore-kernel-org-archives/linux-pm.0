From: Len Brown <len.brown@intel.com>
Subject: Re: Dynanic On-The-Fly Operating points for PowerOP
Date: Wed, 16 Aug 2006 11:02:37 -0400
Message-ID: <200608161102.37871.len.brown@intel.com>
References: <44D8D40F.50005@mvista.com>
	<acd2a5930608120107k36653863vdfc8bd3875d395a9@mail.gmail.com>
	<064e1613db40023e58967726efc3ea13@mvista.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <064e1613db40023e58967726efc3ea13@mvista.com>
Content-Disposition: inline
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
Cc: david singleton <dsingleton@mvista.com>
List-Id: linux-pm@vger.kernel.org

On Saturday 12 August 2006 17:41, david singleton wrote:
> Here's the powerop-x86-centrino.patch.

Please do not propagate the hard coded tables and control word formats
from speedstep-centrino.c.  The ACPI tables are preferred,
and the hard-coded tables and control word formats in speedstep-centrino
are known to be inaccurate and unsupported.

Also, there needs to be a mechanism where the tables can change at run-time.

-Len
