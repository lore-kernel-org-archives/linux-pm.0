From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: what handles disk drive(s) shutdown?
Date: Thu, 9 Feb 2006 14:11:15 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0602091407590.7095@shark.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============054121921688180752=="
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

--===============054121921688180752==
Content-Type: TEXT/PLAIN; charset=US-ASCII


in Documentation/power/devices.txt, I read:

<quote>
System shutdown -- at least disks need to be spun down, or data may be
lost. Quiesce devices, just to make life easier for BIOS. event =
FREEZE, flags = SYSTEM_SHUTDOWN
</quote>

Is this actually done somewhere?  I can't find /SYSTEM_SHUTDOWN/
in any kernel .h or .c files.

Thanks,
-- 
~Randy

--===============054121921688180752==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============054121921688180752==--
