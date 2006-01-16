From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Userspace interface breakage in power/state
Date: Mon, 16 Jan 2006 00:27:03 +0000
Message-ID: <20060116002703.GA4769@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============21185229720145116=="
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
To: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============21185229720145116==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

(Resent, without the wrong address for lkml)

In older kernels, power/state for PCI devices took a PCI power state as 
an argument and so "3" was an entirely sensible thing to echo into it. 
In current kernels, it hits a BUG() in pci_choose_state and things blow 
up.

While I realise that the former interface was broken and wrong, would it 
be possible to move to a new one without breaking existing code? 
-- 
Matthew Garrett | mjg59@srcf.ucam.org

-- 
Matthew Garrett | mjg59@srcf.ucam.org

--===============21185229720145116==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============21185229720145116==--
