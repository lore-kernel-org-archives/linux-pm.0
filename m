From: Patrick Mochel <mochel@digitalimplant.org>
Subject: [PATCH 0/4] Fix runtime device suspend/resumre interface
Date: Mon, 20 Feb 2006 16:55:34 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0602201641380.21145-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============52613298125766894=="
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
To: greg@kroah.com, akpm@osdl.org, torvalds@osdl.org
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============52613298125766894==
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi there,

Here is an updated version of the patches to fix the sysfs interface for
runtime device power management by restoring the file to its originally
designed behavior - to place devices in the power state specified by the
user process writing to the file.

Recently, the interface was changed to filter out values to prevent a
BUG() that was introduced in the PCI power management code. While a valid
fix, it makes the driver core filter values that might otherwise be used
by the bus/device drivers. This behavior enforces a hard-coded,
non-configurable policy in the driver core, and prevents any other power
state besides "on" and "off" from being used.

These patches implement a solution to that problem by introducing a
"state" field to the pm_message_t structure, which is passed to the bus
drivers for each suspend request. The sysfs interface is modified to
forward the value written to the file in the .state field. The bus and
device drivers can use that field as guidance for which power state to
enter.

While not the only solution to the problem, this solution should restore
the desired functionality to the per-device "state" file with the least
amount of impact.

Thanks,


	Pat

--===============52613298125766894==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============52613298125766894==--
