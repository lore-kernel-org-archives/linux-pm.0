From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Userspace interface breakage in power/state
Date: Mon, 16 Jan 2006 20:20:36 +0100
Message-ID: <20060116192036.GA6851@elf.ucw.cz>
References: <20060116002516.GB4648@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============19263679857023086=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060116002516.GB4648@srcf.ucam.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.osdl.org, linux-kernel@linux.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============19263679857023086==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Po 16-01-06 00:25:17, Matthew Garrett wrote:
> In older kernels, power/state for PCI devices took a PCI power state as 
> an argument and so "3" was an entirely sensible thing to echo into it. 
> In current kernels, it hits a BUG() in pci_choose_state and things blow 
> up.
> 
> While I realise that the former interface was broken and wrong, would it 
> be possible to move to a new one without breaking existing code? 

I had patch to fix this breakage, but it was rejected. What depends on
that code?
								Pavel
-- 
Thanks, Sharp!

--===============19263679857023086==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============19263679857023086==--
