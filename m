From: Greg KH <greg@kroah.com>
Subject: Re: [RFC] power trees
Date: Thu, 11 Aug 2005 11:29:37 -0700
Message-ID: <20050811182937.GE15803@kroah.com>
References: <1123735844.4380.64.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============66010726861716007=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1123735844.4380.64.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <abelay@novell.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============66010726861716007==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 11, 2005 at 04:50:41AM +0000, Adam Belay wrote:
> struct pm_node {
> 	struct semaphore	sem;
> 	struct list_head	children;
> 	struct list_head	child_list;
> 	struct pm_node		*parent;
> 	struct pm_node		*tmp_path;
> 	struct device		*dev;
> 
> 	struct pm_node_driver	*drv;
> 	unsigned int		current_state;
> 	unsigned int		target_state;
> 
> 	unsigned int		num_states;
> 	struct pm_state		*states;
> };

Shouldn't this structure contain a kobject?  Or do you not want to
represent the power node tree in sysfs?

thanks,

greg k-h

--===============66010726861716007==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============66010726861716007==--
