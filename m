From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] Block on access to temporarily unavailable
	pci device
Date: Wed, 18 Oct 2006 08:51:42 -0600
Message-ID: <20061018145141.GO22289@parisc-linux.org>
References: <45354A59.3010109@us.ibm.com>
	<Pine.LNX.4.44L0.0610181035140.6766-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610181035140.6766-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Brian King <brking@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Adam Belay <abelay@MIT.EDU>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 18, 2006 at 10:38:20AM -0400, Alan Stern wrote:
> You have to do _something_, because a user task could be about to read the
> configuration space at the exact moment you want to start the BIST.  That
> means ipr would have to wait until the user access is finished, which
> means it has to be prepared to sleep one way or another.

Actually, it only has to spin until the user has finished accessing
config space.  See the patch I just posted.
