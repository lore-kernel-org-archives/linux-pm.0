From: "Leo L. Schwab" <lschwab@tapwave.com>
Subject: What's Left at Shutdown?
Date: Wed, 08 Jun 2005 15:09:59 -0700
Message-ID: <42A76CB7.6080606@tapwave.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9133687010565259=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============9133687010565259==
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

.	How much of the kernel is left standing by the time a driver's .shutdown() 
vector is called?

	We have some hardware we'd like to power off when the system shuts down, 
but also during run time when the HW is not in use.  During run time, we can 
rely on interrupt handlers and the various wait_event*() calls working, but 
during the various stages of a full shutdown, this is less clear.

	The hardware in question is programmed by writing commands, then waiting 
for a completion interrupt.  We would prefer to use the same 
(interrupt-driven) code path for both "normal" operation and system 
shutdown.  So what services are guaranteed to be available -- and which are 
guaranteed to be unavailable -- when a driver's .shutdown() vector is called?

	Thanks in advance.

					Schwab

--===============9133687010565259==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============9133687010565259==--
