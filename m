From: Patrick Mochel <mochel@digitalimplant.org>
Subject: [PATCH 0/5] Fix device suspend/resume
Date: Fri, 17 Feb 2006 18:03:26 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0602171745410.30811-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============052114168102305847=="
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
To: greg@kroah.com, torvalds@osdl.org, akpm@osdl.org
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============052114168102305847==
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi there,

Following is a small series of patches to fix up the changes recently made
to the runtime suspend/resume functionality.

The sysfs interface was changed so that it dropped the actual state that
the device was requested to enter. These patches add a state field to
pm_message_t, so that the bus and device drivers can the use value written
to the sysfs file to choose the proper state to enter.

pci_choose_state() is fixed up to check for a non-zero value when the
request is for a PM_EVENT_SUSPEND message and return the appropriate D
state. This allows D1 and D2 to be used once again (though there are few
drivers that currently support it). The BUG() is also converted to a more
friendly WARN_ON(1) when an invalid state is entered.

Finally, the device suspend/resume code is now liberated from an
unconditional deadlock when SMP is enabled.

Please apply. Thanks,


	Pat


--===============052114168102305847==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============052114168102305847==--
