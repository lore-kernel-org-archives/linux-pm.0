From: Christoph Hellwig <hch@infradead.org>
Subject: Re: PM/hibernate swapfile regression
Date: Tue, 21 Jul 2009 17:55:36 -0400
Message-ID: <20090721215536.GA9502__46469.6597344757$1248213607$gmane$org@infradead.org>
References: <20090714135453.GA26976@osiris.boeblingen.de.ibm.com>
	<200907141821.06101.rjw@sisk.pl> <4A6077DE.6060202@tuffmail.co.uk>
	<20090720132456.GA29023@osiris.boeblingen.de.ibm.com>
	<4A659D75.3050004@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A659D75.3050004@tuffmail.co.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Arnd Schneider <arnd@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Hans-Joachim Picht <hans@linux.vnet.ibm.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 21, 2009 at 11:50:29AM +0100, Alan Jenkins wrote:
> +struct block_device *bdcopy(struct block_device *bdev)
> +{
> +	atomic_inc(&bdev->bd_inode->i_count);
> +	return bdev;
> +}
> +
> +EXPORT_SYMBOL(bdcopy);

The function name doesn't make any sense.  You don't copy anything
here, but you grab a reference to it.  A better name would be bdgrab,
mirroing the names of functions like igrab.  A kerneldoc comment
documenting it would also be very helpful.

Why do you export it?  The swapfile code is not actually modular.
