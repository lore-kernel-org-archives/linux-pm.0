From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 2/6] swsusp: move snapshot-handling
	functions to snapshot.c
Date: Sun, 30 Oct 2005 00:27:48 +0200
Message-ID: <20051029222748.GC14209@elf.ucw.cz>
References: <200510292158.11089.rjw@sisk.pl> <200510292206.23166.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============45892769763949381=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200510292206.23166.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@osdl.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============45892769763949381==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On So 29-10-05 22:06:22, Rafael J. Wysocki wrote:
> This is another preliminary step.  It moves the snapshot-handling functions
> remaining in swsusp.c to snapshot.c (moving the code without changing
> the functionality) and makes the next patch be more clear (in my opinion).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK and thanks.
								Pavel
-- 
Thanks, Sharp!

--===============45892769763949381==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============45892769763949381==--
