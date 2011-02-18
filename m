From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: regression 2.6.38-rc4 -> 2.6.38-rc5 suspend fails
Date: Fri, 18 Feb 2011 18:49:17 +0100
Message-ID: <201102181849.17589.rjw__8713.50262682444$1298051449$gmane$org@sisk.pl>
References: <20110217163300.GA7988@gamma.logic.tuwien.ac.at>
	<201102172309.26106.rwys@fuw.edu.pl>
	<20110218025601.GA30118@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110218025601.GA30118@gamma.logic.tuwien.ac.at>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Norbert Preining <preining@logic.at>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Rajiv Andrade <srajiv@linux.vnet.ibm.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Guillaume Chazarain <guichaz@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, February 18, 2011, Norbert Preining wrote:
> On Do, 17 Feb 2011, R. J. Wysocki wrote:
> > > [  187.431895] sd 0:0:0:0: [sda] Stopping disk
> > > [  187.480078] tpm_tis 00:0a: Operation Timed out
> > > [  187.480095] legacy_suspend(): pnp_bus_suspend+0x0/0x6a returns -62
> > > [  187.480101] PM: Device 00:0a failed to suspend: error -62
> 
> > What happens if you revert commit 9b29050 (tpm_tis: Use timeouts returned from TPM)?
> 
> Reverting this commit the laptop suspends fine again.

Stefan, Rajiv, the above commit causes a suspend regression to appear for
Norbert.  Care to have a look?

Rafael
